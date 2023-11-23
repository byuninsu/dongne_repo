import 'package:daum_postcode_search/daum_postcode_search.dart';
import 'package:dongne/controller/room_controller.dart';
import 'package:dongne/controller/user_controller.dart';
import 'package:dongne/model/address.dart';
import 'package:dongne/view/roomTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remedi_kopo/remedi_kopo.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isAreaId = false;
  TextEditingController _AddressController = TextEditingController();
  String ourArea = '아직 없어요..';

  @override
  void initState() {
    super.initState();
    fetchData();

    //init이 완료된 후 실행되는 콜백에서 진행
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isAreaId) {
        showPopup();
      }
    });
  }

  void fetchData() async {
    //await RoomController.instance.getRoomList();
  }

  void showPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('나의 동네는 ?',
              style: TextStyle(color: Colors.black87, fontSize: 25.0)),
          content: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent
            ),
            child: Text('주소 찾기',style: TextStyle(color: Colors.white, fontSize: 25.0)),
            onPressed: () async {
              KopoModel model = await Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => RemediKopo(),
                ),
              );

              Address userAddress = Address(
                  model.buildingName.toString(),
                  model.address.toString(),
                  model.sido.toString(),
                  model.sigungu.toString()
              );

              UserController.instance.setUserAddress(userAddress);

              
              _AddressController.text =
              '${model.zonecode!} ${model.address!} ${model.buildingName!}';

              if(_AddressController.text != null){
                setState(() {
                  ourArea = _AddressController.text;
                  Navigator.pop(context);
                });
              }
            },
          ),
          actions: [],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              "채팅창 리스트",
              style: GoogleFonts.notoSans(
                  textStyle: TextStyle(color: Colors.black)),
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black87),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  child: Icon(Icons.location_on_outlined),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 300,
                  child: Text(
                    "우리 동네는?",
                    style: GoogleFonts.notoSans(),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 300,
              child: Text(
                ourArea,
                style: GoogleFonts.notoSans(),
              ),
            ),
            Expanded(
              child: Obx(() => GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 1.5),
                    itemCount: RoomController.instance.roomList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: RoomTile(
                            room: RoomController.instance.roomList[index]),
                      );
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }
}
