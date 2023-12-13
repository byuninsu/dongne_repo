import 'package:dongne/controller/menuIndex_controller.dart';
import 'package:dongne/controller/room_controller.dart';
import 'package:dongne/controller/user_controller.dart';
import 'package:dongne/view/loginPage.dart';
import 'package:dongne/view/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'firebase_options.dart';

void main() async {

  //카카오
  KakaoSdk.init(nativeAppKey: '9cccb013e001c7d23a8bad7125e4c8e4');

  //네이버
  WidgetsFlutterBinding.ensureInitialized();

  //파이어베이스
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );


  runApp( MyApp());

  //GetX
  Get.put(RoomController());
  Get.put(UserController());
  Get.put(MenuIndexController());

}

class MyApp extends StatelessWidget {
   MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      home: LoginPage(),
    );
  }
}

