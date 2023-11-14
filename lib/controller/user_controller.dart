import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../api/api.dart';
import '../model/user.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();


  Future<void> examplePost() async {
    print("examplePost++ ");

    User sampleUser =  new User(
    'insu8897@naver.com',
    'dkdkdkdawdj',
    '010-4404-4239',
    'http',
    true,
    'token',
    'role',
    null,
    '1234',
    null,
    null,
    null,
    null
    );

    print(sampleUser.toJson());

    try {
      var res = await http.post(Uri.parse(API.userSignUp),
          body: sampleUser.toJson()
      );
      print('postAddress : ${API.userSignUp}');

      if (res.statusCode == 200) {
        var resUser = jsonDecode(res.body);
        print("가입성공");
        print(resUser);
      } else {
        print("sign not success res.statusCode : ${res.statusCode}");
        print("res : ${res.body}" );
      }
    } catch (e) {
      print("try exception !!${e.toString()} ");
    }
  }


}