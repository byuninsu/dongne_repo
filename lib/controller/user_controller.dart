import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../api/api.dart';
import '../model/userInfo.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();

  static const storage =  FlutterSecureStorage();
  final String loginKey = 'accessToken';

  String? userAccessToken;

  Future<void> signupUser(UserInformation userInformation) async {
    print("examplePost++ ");

    // UserInformation sampleUser = UserInformation(
    //     'insu8897@naver.com', 'dkdkdkdawdj', '010-4404-4239',
    //     'http', true, 'token', 'role', null, '1234', null, null, null, null
    // );

    print(userInformation.toJson());

    try {
      var res =
          await http.post(Uri.parse(API.userSignUp), body: userInformation.toJson());
      print('postAddress : ${API.userSignUp}');

      if (res.statusCode == 200) {
        var resUser = jsonDecode(res.body);
        print("가입성공");
        print(resUser);
      } else {
        print("sign not success res.statusCode : ${res.statusCode}");
        print("res : ${res.body}");
      }
    } catch (e) {
      print("try exception !!${e.toString()} ");
    }
  }

  void signInWithGoogle() async {
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
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {


      try{
        await storage.write(
            key:loginKey,
            value: value.user!.uid
        );
        print("Google login success!! : ${value.user!.uid} ");
      }catch (e){
        print("Error writing to storage: $e");
      }

    }).onError((error, stackTrace)  {
      print('signInWithGoogle error : ${error}');
    });
  }



  Future<String?> getUserToken() async {
    // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
    // 데이터가 없을때는 null을 반환

    try{
      userAccessToken = await storage. read(key:loginKey);
    }catch (e){
      print("Error reading to storage: $e");
    }

    print("userAccessToken: $userAccessToken");

    // user의 정보가 있다면 로그인 후 들어가는 첫 페이지로 넘어가게 합니다.
    if (userAccessToken != null) {
      print('login info : ${userAccessToken}');
      return userAccessToken;
    } else {
      print('로그인이 필요합니다');
    }
    return null;
  }

  logout() async {
    await storage.delete(key: 'accessToken');
  }

// checkUserState() async {
//   userAccessToken = await storage.read(key: 'accessToken');
//   if (userAccessToken == null) {
//     print('로그인 페이지로 이동');
//     Navigator.pushNamed(context, '/'); // 로그인 페이지로 이동
//   } else {
//     print('로그인 중');
//   }
// }


}
