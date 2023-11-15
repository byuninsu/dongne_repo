import 'package:dongne/controller/room_controller.dart';
import 'package:dongne/controller/user_controller.dart';
import 'package:dongne/view/loginPage.dart';
import 'package:dongne/view/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
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

  String? userToken;

  void checkUserLogin(){
    UserController.instance.getUserToken().then((value) {
      if(value != null){
        userToken = value;
      }
    });

    if(userToken != null){
      Get.to(MainPage());
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      home: LoginPage(),
    );
  }
}

