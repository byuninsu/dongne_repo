import 'dart:convert';
import 'dart:ffi';
import 'package:dongne/model/address.dart';
import 'package:dongne/view/mainPage.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import '../api/api.dart';
import '../model/userInfo.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();

  static const storage = FlutterSecureStorage();
  final String loginKey = 'accessToken';
  late Rx<String?> userAccessToken = Rx<String?>(null);
  int? userAreaId;

  String? currentUserAddress;

  String? userLatitude;

  String? userLongitude;

  late Rx<User?> currentUser = Rx<User?>(null);
  kakao.User? kakaoUser;
  bool isKakaoUserLogin = false;

  @override
  void onInit() {
    ever(userAccessToken, (String? accessToken) {
      if (accessToken != null) {
        Get.to(MainPage());
      }
    });
  }

  Future<bool> isCheckUserAccessToken() async {
    userAccessToken.value = await storage.read(key: loginKey);
    if (userAccessToken.value != null) {
      print("current userAccessToken : ${userAccessToken.value}");
      return true;
    } else {
      return false;
    }
  }

  Future<void> signupUser(UserInformation userInformation) async {
    print('signupUser data : ${userInformation.toJson()}');

    try {
      var res = await http.post(Uri.parse(API.userSignUp),
          body: userInformation.toJson());

      int firstDigit = res.statusCode ~/ 100;

      if (firstDigit == 2) {
        Map<String, dynamic> resultMessage = json.decode(res.body);

        print("가입성공");
        print("res : ${resultMessage}");

        storage.write(key: 'accessToken', value: resultMessage['accessToken']);
        storage.write(
            key: 'refreshToken', value: resultMessage['refreshToken']);

        print('user accessToken : ${storage.read(key: 'accessToken')}');
        print('user refreshToken : ${storage.read(key: 'refreshToken')}');
      } else {
        print("sign not success res.statusCode : ${res.statusCode}");
        print("res : ${res.body}");
      }
    } catch (e) {
      print("try exception !!${e.toString()} ");
    }
  }

  Future<bool> loginUser(UserInformation userInformation) async {
    print('loginUser data : ${userInformation.toJson()}');

    Map<String, dynamic> data = userInformation.toJson();

    try {
      var res = await http.post(Uri.parse(API.userLogin), body: data);

      int firstDigit = res.statusCode ~/ 100;

      if (firstDigit == 2) {
        Map<String, dynamic> resultMessage = json.decode(res.body);

        print("로그인성공");
        print("res : ${resultMessage}");

        storage.write(key: 'accessToken', value: resultMessage['accessToken']);
        storage.write(
            key: 'refreshToken', value: resultMessage['refreshToken']);

        print(
            'storage write user accessToken : ${await storage.read(key: 'accessToken')}');
        print(
            'storage write user refreshToken : ${await storage.read(key: 'refreshToken')}');

        userAccessToken.value = await storage.read(key: 'accessToken');

        return true;
      } else {
        print("sign not success res.statusCode : ${res.statusCode}");
        print("res : ${res.body}");
        return false;
      }
    } catch (e) {
      print("try exception !!${e.toString()} ");
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) async {
      try {
        await storage.write(key: 'accessToken', value: value.user!.uid);
        UserInformation googleUserData = UserInformation(
            value.user!.email.toString(),
            value.user!.displayName.toString(),
            '010-3273-3273',
            value.user!.photoURL.toString(),
            true,
            null,
            'USER',
            value.user!.uid,
            '1234ffff',
            null,
            null,
            null,
            null);

        if (await storage.read(key: 'accessToken') == null) {
          signupUser(googleUserData);
        } else {
          loginUser(googleUserData);
        }

        return true;
      } catch (e) {
        print("Error writing to storage: $e");
        return false;
      }
    }).onError((error, stackTrace) {
      print('signInWithGoogle error : ${error}');
      return false;
    });

    return false;
  }

  Future<String?> getGoogleUserToken() async {
    // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
    // 데이터가 없을때는 null을 반환

    try {
      userAccessToken.value = await storage.read(key: loginKey);
    } catch (e) {
      print("Error reading to storage: $e");
    }

    print("userAccessToken: $userAccessToken");

    // user의 정보가 있다면 로그인 후 들어가는 첫 페이지로 넘어가게 합니다.
    if (userAccessToken != null) {
      print('login info : ${userAccessToken}');
      return userAccessToken.value;
    } else {
      print('로그인이 필요합니다');
    }
    return null;
  }

  logout() async {
    await storage.delete(key: 'accessToken');
  }

  Future<bool> kakaoLogin() async {
    try {
      bool isInstalled = await kakao.isKakaoTalkInstalled();
      if (isInstalled) {
        try {
          kakao.OAuthToken token =
              await kakao.UserApi.instance.loginWithKakaoAccount();
          //OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
          print("kakao login success User : ${token}");
          return true;
        } catch (e) {
          print("kakao login fair errorCode : ${e}");
          return false;
        }
      } else {
        try {
          print("kakao Account login ++ ");
          kakao.OAuthToken token =
              await kakao.UserApi.instance.loginWithKakaoAccount();
          return true;
        } catch (e) {
          print("kakaoAccount login fair errorCode : ${e}");
          return false;
        }
      }
    } catch (e) {
      print("kakao login fair errorCode : ${e}");
      return false;
    }
  }

  Future<bool> kakaoLogout() async {
    try {
      await kakao.UserApi.instance.unlink();
      return true;
    } catch (e) {
      print("kakao logout fair errorCode : ${e}");
      return false;
    }
  }

  void naeverLoingin() async {
    final NaverLoginResult result = await FlutterNaverLogin.logIn();

    if (result.status == NaverLoginStatus.loggedIn) {
      print('accessToken = ${result.accessToken}');
      print('id = ${result.account.id}');
      print('email = ${result.account.email}');
      print('name = ${result.account.name}');
    }
  }

  void naverLogout() async {
    await FlutterNaverLogin.logOut();
  }

  Future<bool> checkUserAddress(Address userAddress) async {
    print("userAccessToken.toString() : ${userAccessToken.toString()}");

    try {
      var res = await http.put(Uri.parse(API.checkUserAddress),
          headers: <String, String>{
            'Authorization': 'Bearer ${userAccessToken.toString()}'
          },
          body: userAddress.toJson());

      int firstDigit = res.statusCode ~/ 100;

      if (firstDigit == 2) {
        Map<String, dynamic> resultMessage = json.decode(res.body);
        print("유저 주소 검색 완료");
        print("res : ${resultMessage}");

        //받아온 userAreaId 를 storage에 저장

        currentUserAddress = resultMessage['address'];
        userAreaId = resultMessage['id'];
        userLatitude = resultMessage['latitude'];
        userLongitude = resultMessage['longitude'];

        setUserArea(userAreaId!);

        return true;
      } else {
        print("유저 주소 등록 실패");
        print("res : ${res.body}");
        return false;
      }
    } catch (e) {
      print("try exception !!${e.toString()} ");
    }

    return false;
  }

  Future<bool> setUserArea(int userAreaId) async {
    Map<String, int> userAreaMap = {"areaId": userAreaId};

    print("setUserArea : ${jsonEncode(userAreaMap)}");
    print("userAccessToken.value : ${userAccessToken.value}");

    try {
      var res = await http.put(Uri.parse(API.setUserAreaId),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${userAccessToken.value}'
          },
          body: jsonEncode(userAreaMap));

      int firstDigit = res.statusCode ~/ 100;

      if (firstDigit == 2) {
        print("유저 지역 등록 완료");

        return true;
      } else {
        print("유저 지역 등록 실패");
        return false;
      }
    } catch (e) {
      print("try exception !!${e.toString()} ");
    }

    return false;
  }

  Future<bool> getUserAreaId() async {
    try {
      var res = await http.get(
        Uri.parse(API.getIsAddress),
        headers: <String, String>{
          'Authorization': 'Bearer ${userAccessToken.toString()}'
        },
      );

      int firstDigit = res.statusCode ~/ 100;

      if (firstDigit == 2) {
        Map<String, dynamic> resultMessage = json.decode(res.body);

        print("지역 받아오기 성공");
        print("res : ${resultMessage}");
        userAreaId = resultMessage['id'];
        currentUserAddress = resultMessage['address'];
        userLatitude = resultMessage['latitude'];
        userLongitude = resultMessage['longitude'];

        return true;
      } else {
        print("지역 받아오기 실패");
        print("res : ${res.body}");
        return false;
      }
    } catch (e) {
      print("try exception !!${e.toString()} ");
      return false;
    }
  }
}
