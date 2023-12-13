import 'dart:convert';

import 'package:dongne/controller/user_controller.dart';
import 'package:dongne/view/menuPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../api/api.dart';
import '../model/room.dart';
import 'package:http/http.dart' as http;

class RoomController extends GetxController {
  static RoomController instance = Get.find();

  var roomList = <Room>[].obs;
  int roomNumber = 0;
  Room? roomInfo;

  Room getRoomInfo() {
    print("getRoomInfo() ++");

    if (roomInfo != null) {
      return roomInfo!;
    } else {
      return Room.defaultRoom();
    }
  }

  void clearRoomInfo() {
    roomInfo = null;
  }

  Future<bool> createRomm(Room room) async {
    print("createRomm : ${room.toJson()}");
    try {
      var res = await http.post(Uri.parse(API.createRoom),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${UserController.instance.userAccessToken.value}'
          },
          body: jsonEncode(room.toJson()));

      int firstDigit = res.statusCode ~/ 100;

      if (firstDigit == 2) {
        print("방 생성 완료");

        Get.to(MenuPage());

        return true;
      } else {
        print("방 생성 실패");
        print("res.body : ${res.body}");
        return false;
      }
    } catch (e) {
      print("try exception!! e : ${e}");
    }

    return false;
  }

  // Future<int> choiceRoom(String receiveRoomNumber) async {
  //   print("choiceRoom++ receiveRoomNumber : ${receiveRoomNumber}");
  //   int roomNumber = 1;
  //
  //   try {
  //     //body 내용을 API.login에 전달하여 받은 return값을 res에 저장
  //     var res = await http.post(Uri.parse(API.choiceRoom), body: {
  //       "room_number": receiveRoomNumber,
  //     });
  //
  //     //반환받은 res값이 200(정상) 이면 해당 리턴값(json)을 확인하여 성공일때와 아닐때를 구분하여 코드진행
  //     if (res.statusCode == 200) {
  //       var resLogin = jsonDecode(res.body);
  //       if (resLogin['success'] == true) {
  //         print("choiceRoom success");
  //
  //         roomInfo = Room.fromJson(resLogin['roomData']);
  //         roomNumber = roomInfo!.room_number;
  //         setOption();
  //
  //       } else {
  //         print("receiveDbUser not success");
  //       }
  //     } else {
  //       print("res.statusCode not 200, statusCode = ${res.statusCode} ");
  //     }
  //   } catch (e) {
  //     print("try exception !!${e.toString()} ");
  //   }
  //
  //   return roomNumber;
  // }

  void createRoom() {
    print("createRoom() ++");
    getRoomList();
  }

  int getRoomNumber() {
    roomNumber = roomList.length + 1;
    return roomNumber;
  }

  Future<void> getRoomList() async {
    try {
      //body 내용을 API.login에 전달하여 받은 return값을 res에 저장
      var res = await http.get(
        Uri.parse(API.searchRoomList),
        headers: <String, String>{
          'Authorization': 'Bearer ${UserController.instance.userAccessToken}'
        },
      );

      //반환받은 res값이 200(정상) 이면 해당 리턴값(json)을 확인하여 성공일때와 아닐때를 구분하여 코드진행
      if (res.statusCode == 200) {
        //var resBody = jsonDecode(res.body);
        print('방 리스트 수신 성공 !');

        roomList.clear();

        List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>.from(json.decode(res.body));


        // 데이터 출력
        for (Map<String, dynamic> data in dataList) {
          Room room = Room.fromJson(data);
          roomList.add(room);
        }

        // List<dynamic> stringRoomlist = resBody['roomList'];
        //
        // roomList.clear();
        //
        // for (int i = 0; i < stringRoomlist.length; i++) {
        //   Map<String, dynamic> mapRoom = stringRoomlist[i];
        //   Room room = Room.fromJson(mapRoom);
        //   roomList.add(room);
        // }
      } else {
        print("방 리스트 수신 실패 res.statusCode : ${res.statusCode}, res.body :  ${res.body}" );
      }
    } catch (e) {
      print("방 리스트 수신 실패  try exception !!${e.toString()}");
    }
  }


  Future<void> recordRoom() async {
    try {
      //body 내용을 API.login에 전달하여 받은 return값을 res에 저장
      var res = await http.get(
        Uri.parse(API.chatRoomRecord),
        headers: <String, String>{
          'Authorization': 'Bearer ${UserController.instance.userAccessToken}'
        },
      );

      //반환받은 res값이 200(정상) 이면 해당 리턴값(json)을 확인하여 성공일때와 아닐때를 구분하여 코드진행
      if (res.statusCode == 200) {
        //var resBody = jsonDecode(res.body);
        print('참여중인 방정보 수신 성공 !');

        roomList.clear();

        roomNumber = int.parse(res.body);

        print("roomNumber : ${roomNumber}");

        for(int i=0; i<roomList.length; i++ ){
          if(roomList[i].id == roomNumber){
            roomInfo = roomList[i];
          }
        }
      } else {
         print("참여중인 방정보 수신 실패 res.statusCode : ${res.statusCode}, res.body :  ${res.body}" );
      }
    } catch (e) {
      print("참여중인 방정보 수신 실패  try exception !!${e.toString()}");
    }
  }
}
