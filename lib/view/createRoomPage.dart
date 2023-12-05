import 'dart:convert';

import 'package:dongne/controller/room_controller.dart';
import 'package:dongne/controller/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;

import '../model/room.dart';

class CreateRoomPage extends StatefulWidget {
  const CreateRoomPage({Key? key}) : super(key: key);

  @override
  State<CreateRoomPage> createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  final String userAreaIdKey = 'userAreaId';
  final String userAddressKey = 'userAddress';

  String storeLongitude = '0';
  String storeLatitude = '0';

  var formKey = GlobalKey<FormState>();

  var roomNameController = TextEditingController();
  var orderLinkController = TextEditingController();
  var restaurantController = TextEditingController();
  var deliveryFeeController = TextEditingController();

  String userAddress = "신규 등록 필요";
  TimeOfDay initialTime = TimeOfDay.now();
  DateTime nowTime = DateTime.now();

  String selectedFoodValue = '치킨';
  List<Map<String, dynamic>> dropdownItems = [
    {'value': '치킨', 'image': 'images/chicken.png'},
    {'value': '피자', 'image': 'images/chicken.png'},
    {'value': '샐러드', 'image': 'images/chicken.png'},
  ];

  String selectedHumanValue = '1';
  List<Map<String, dynamic>> humanDropdownItems = [
    {'value': '1', 'text': '1명'},
    {'value': '2', 'text': '2명'},
    {'value': '3', 'text': '3명'},
    {'value': '4', 'text': '4명'},
  ];

  Future<void> createRoomReq() async {
    //주소 변환
    await bringStoreAddress();

    UserController.storage.read(key: userAreaIdKey);
    UserController.storage.read(key: userAreaIdKey);
    UserController.storage.read(key: userAreaIdKey);

    //DateTime형태로 변환
    DateTime combinedDateTime = DateTime(
      nowTime.year,
      nowTime.month,
      nowTime.day,
      initialTime.hour,
      initialTime.minute,
    );

    String formattedDateTime =
        DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(combinedDateTime);

    Room reqRoom = Room(
        roomNameController.text.trim(),
        orderLinkController.text.trim(),
      storeLongitude,
      storeLatitude,
      restaurantController.text.trim(),
        selectedFoodValue,
        int.parse(selectedHumanValue),
      int.parse(deliveryFeeController.text.trim()),
      formattedDateTime,
        1,
        UserController.instance.userAreaId!,
    );

    await RoomController.instance.createRomm(reqRoom);
  }

  Future<void> bringStoreAddress() async {
    String storeAddress = restaurantController.text.trim();
    String apiKey = '4f7e299da05c68f995e0ac1007cb4c71';

    try{
      final response = await http.get(
        Uri.parse('https://dapi.kakao.com/v2/local/search/keyword.json?query=$storeAddress'),
        headers: {'Authorization': 'KakaoAK $apiKey'},
      );

      if(response.statusCode == 200){
        Map<String,dynamic> responseData = json.decode(response.body);

        // //검색 결과 위,경도 가져오기
        storeLatitude =responseData['documents'][0]['y'];
        storeLongitude = responseData['documents'][0]['x'];

      }

    }catch (e){
      print('가게 주소가져오기 실패! ${e}');
    }

  }

  // Future<void> bringOrderInformation() async {
  //   String orderLink = orderLinkController.text.trim();
  //   if (orderLink != null){
  //     try{
  //       final response = await http.get(Uri.parse(orderLink));
  //       if(response.statusCode == 200){
  //         final document = htmlParser.parse(utf8.decode(response.bodyBytes));
  //
  //         //메타데이터 추출
  //         String title = document.head!
  //             .querySelector('meta[property="og:title"]')
  //             ?.attributes['content'] ?? 'No Title';
  //
  //         String description = document.head!
  //             .querySelector('meta[property="og:description"]')
  //             ?.attributes['content'] ?? 'No description';
  //
  //         String bodyDescription = document.body!
  //             .querySelector('meta[property="og:description"]')
  //             ?.attributes['content'] ?? 'No description';
  //
  //
  //         print('url title : ${title}' );
  //         print('url description : ${description}' );
  //         print('url all : ${bodyDescription}' );
  //       }
  //     }catch (e){
  //       print("링크에서 정보 가져오기 실패 ! : $e");
  //     }
  //   }
  // }


  @override
  void initState() {
    userAddress = UserController.instance.currentUserAddress!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "방만들기",
            style: GoogleFonts.bebasNeue(
                fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.exit_to_app_sharp))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  width: 350,
                  height: 35,
                  alignment: Alignment.topLeft,
                  child: Text(
                    "방 제목",
                    style: GoogleFonts.bebasNeue(fontSize: 12.0),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 10, 5),
                child: Container(
                  width: 350,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextFormField(
                      controller: roomNameController,
                      validator: (val) => val == "" ? "방제목을 입력해주세요" : null,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: '00동 치킨드실분 ?'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: 160,
                          height: 35,
                          alignment: Alignment.topLeft,
                          child: Text(
                            "음식 종류",
                            style: GoogleFonts.bebasNeue(fontSize: 12.0),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30),
                        width: 160,
                        child: DropdownButton(
                          value: selectedFoodValue,
                          isExpanded: true,
                          underline: SizedBox(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedFoodValue = newValue.toString();
                            });
                          },
                          items: dropdownItems
                              .map<DropdownMenuItem<String>>((item) {
                            return DropdownMenuItem<String>(
                              value: item['value'],
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      item['image'],
                                      width: 40,
                                      height: 40,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      item['value'],
                                      style:
                                          GoogleFonts.bebasNeue(fontSize: 15.0),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: 160,
                          height: 35,
                          alignment: Alignment.topLeft,
                          child: Text(
                            "참여 인원",
                            style: GoogleFonts.bebasNeue(fontSize: 12.0),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 20),
                        width: 160,
                        alignment: Alignment.center,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          underline: SizedBox(),
                          value: selectedHumanValue,
                          onChanged: (newValue) {
                            setState(() {
                              selectedHumanValue = newValue.toString();
                            });
                          },
                          items: humanDropdownItems
                              .map<DropdownMenuItem<String>>((item) {
                            return DropdownMenuItem<String>(
                              value: item['value'],
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  item['text'],
                                  style:
                                      GoogleFonts.bebasNeue(fontSize: 15.0),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  width: 350,
                  height: 35,
                  alignment: Alignment.topLeft,
                  child: Text(
                    "나의 주소",
                    style: GoogleFonts.bebasNeue(fontSize: 12.0),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 10, 5),
                child: Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      userAddress,
                      style: GoogleFonts.bebasNeue(fontSize: 15.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  width: 350,
                  height: 35,
                  alignment: Alignment.topLeft,
                  child: Text(
                    "배달의민족 함께하기 링크",
                    style: GoogleFonts.bebasNeue(fontSize: 12.0),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 10, 5),
                    child: Container(
                      width: 350,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: TextFormField(
                          controller: orderLinkController,
                          validator: (val) => val == "" ? "링크를 입력해주세요" : null,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'http://baemin.co.kr'),
                        ),
                      ),
                    ),
                  ),

                  // OutlinedButton(
                  //     style: ButtonStyle(
                  //         backgroundColor:
                  //         MaterialStateProperty.all(Colors.white),
                  //         shape: MaterialStateProperty.all<OutlinedBorder>(
                  //             RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(0)))),
                  //     onPressed: ()  {
                  //       //bringOrderInformation();
                  //     },
                  //     child: Text(
                  //       "가져오기",
                  //       style: GoogleFonts.bebasNeue(fontSize: 15.0),
                  //     )
                  // )

                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  width: 350,
                  height: 35,
                  alignment: Alignment.topLeft,
                  child: Text(
                    "맛집 주소",
                    style: GoogleFonts.bebasNeue(fontSize: 12.0),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 10, 5),
                child: Container(
                  width: 350,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextFormField(
                      controller: restaurantController,
                      validator: (val) => val == "" ? "가게이름을 입력해주세요" : null,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: '예시) 네네치킨 학익동점'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  width: 350,
                  height: 35,
                  alignment: Alignment.topLeft,
                  child: Text(
                    "총 배달비 (원)",
                    style: GoogleFonts.bebasNeue(fontSize: 12.0),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 10, 5),
                child: Container(
                  width: 350,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: deliveryFeeController,
                      validator: (val) => val == "" ? "배달비를 입력해주세요" : null,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: '5,000'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Container(
                  width: 350,
                  height: 35,
                  alignment: Alignment.topLeft,
                  child: Text(
                    "마감 시간 설정",
                    style: GoogleFonts.bebasNeue(fontSize: 12.0),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 10, 5),
                    child: Container(
                      width: 235,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Text(
                          initialTime.format(context),
                          style: GoogleFonts.bebasNeue(fontSize: 15.0),
                        ),
                      ),
                    ),
                  ),
                  OutlinedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)))),
                      onPressed: () async {
                        final TimeOfDay? timeofday = await showTimePicker(
                            context: context, initialTime: initialTime);
                        if (timeofday != null) {
                          setState(() {
                            initialTime = timeofday;
                          });
                        }
                      },
                      child: Text(
                        "시간 설정",
                        style: GoogleFonts.bebasNeue(fontSize: 15.0),
                      ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepOrangeAccent)),
                  onPressed: () async {
                    createRoomReq();
                  },
                  child: Text(
                    "방만들기",
                    style: GoogleFonts.bebasNeue(
                        fontSize: 17.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
