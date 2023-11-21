import 'package:dongne/controller/room_controller.dart';
import 'package:dongne/controller/user_controller.dart';
import 'package:dongne/view/loginPage.dart';
import 'package:dongne/view/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'firebase_options.dart';

void main() async {
  KakaoSdk.init(nativeAppKey: '9cccb013e001c7d23a8bad7125e4c8e4');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp( MyApp());
  Get.put(RoomController());
  Get.put(UserController());

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

