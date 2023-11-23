import 'dart:convert';

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



  Future<Room?> getRoomInfo() async {
    print("getRoomInfo() ++");
    return roomInfo;
  }

  void clearRoomInfo(){
    roomInfo = null;
  }


  // Future<void> voteOption(String roomNumber, String optionNumber) async {
  //   print("RoomController voteOption ++ ");
  //
  //   try{
  //     var res = await http.post(Uri.parse(API.voteOption), body: {
  //       "room_number" :  roomNumber,
  //       "option_number" : optionNumber
  //     });
  //
  //     if(res.statusCode == 200){
  //       var resVote = jsonDecode(res.body);
  //       if(resVote['success'] == true ){
  //         print("투표 성공");
  //       }else{
  //         print("투표 실패 not success");
  //       }
  //     }else{
  //       print("vote not success res.statusCode : ${res.statusCode}");
  //     }
  //   }catch (e){
  //     print("try exception !!${e.toString()} ");
  //   }
  //   updateRoomInfo(roomInfo!.room_number.toString());
  //
  // }

  // Future<void> updateRoomInfo(String roomNumber) async {
  //   print("updateRoomInfo ++  roomNumber : ${roomNumber}");
  //
  //
  //   try {
  //     //body 내용을 API.login에 전달하여 받은 return값을 res에 저장
  //     var res = await http.post(Uri.parse(API.choiceRoom), body: {
  //       "room_number": roomNumber,
  //     });
  //
  //     //반환받은 res값이 200(정상) 이면 해당 리턴값(json)을 확인하여 성공일때와 아닐때를 구분하여 코드진행
  //     if (res.statusCode == 200) {
  //       var resLogin = jsonDecode(res.body);
  //       if (resLogin['success'] == true) {
  //         print("choiceRoom success");
  //
  //         roomInfo = Room.fromJson(resLogin['roomData']);
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
  // }



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
      var res = await http.post(
        Uri.parse(API.searchRoomList),
      );

      //반환받은 res값이 200(정상) 이면 해당 리턴값(json)을 확인하여 성공일때와 아닐때를 구분하여 코드진행
      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success'] == true) {
          print("roomList receive success !");

          List<dynamic> stringRoomlist = resBody['roomList'];

          roomList.clear();

          for (int i = 0; i < stringRoomlist.length; i++) {
            Map<String, dynamic> mapRoom = stringRoomlist[i];
            Room room = Room.fromJson(mapRoom);
            roomList.add(room);
          }
        } else {
          // print("roomList 수신 실패");
        }
      } else {
        // print("데이터베이스 통신 실패, statusCode = ${res.statusCode} ");
      }
    } catch (e) {
      // print("try exception !!${e.toString()}");
    }
  }
}
