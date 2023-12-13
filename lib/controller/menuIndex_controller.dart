import 'package:get/get.dart';

class MenuIndexController extends GetxController{

  static MenuIndexController instance = Get.find();

  Rx<int> menuIndex = 0.obs;

  void setMenuIndex(int input){
    menuIndex.value = input;
  }

  int getMenuIndex(){
    return menuIndex.value;
  }

}