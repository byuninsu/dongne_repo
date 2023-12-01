import 'package:daum_postcode_search/daum_postcode_search.dart';
import 'package:dongne/controller/room_controller.dart';
import 'package:dongne/controller/user_controller.dart';
import 'package:dongne/model/address.dart';
import 'package:dongne/view/createRoomPage.dart';
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
  String ourArea = '아직 없어요';
  final String userAddressKey = 'userAddress';

  @override
  void initState() {
    super.initState();
    initLogic();
  }

  void initLogic() async {
    await fetchData();

    if (!isAreaId) {
      showPopup();
    } else {
      setState(() {
        ourArea = UserController.instance.currentUserAddress!;
      });
    }
  }

  Future<void> fetchData() async {
    isAreaId = await UserController.instance.getUserAreaId();
    ourArea = UserController.instance.currentUserAddress!;

    //await RoomController.instance.getRoomList();
  }

  void showPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('나의 동네는 ?',
              style:
                  GoogleFonts.bebasNeue(fontSize: 15.0, color: Colors.black)),
          content: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent),
            child: Text('주소 찾기',
                style:
                    GoogleFonts.bebasNeue(fontSize: 15.0, color: Colors.white)),
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
                  model.sigungu.toString());

              UserController.instance.checkUserAddress(userAddress);

              _AddressController.text =
                  '${model.zonecode!} ${model.address!} ${model.buildingName!}';

              if (_AddressController.text != null) {
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
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton.extended(
                    onPressed: () {
                      Get.to(CreateRoomPage());
                    },
                    icon: Icon(Icons.add_circle),
                    label: Text("방만들기",
                        style: GoogleFonts.bebasNeue(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15)),
                    backgroundColor: Colors.deepOrangeAccent,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
