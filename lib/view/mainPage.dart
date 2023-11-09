import 'package:dongne/controller/room_controller.dart';
import 'package:dongne/view/roomTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> {

  @override
  void initState() {
    fetchData();
  }

  void fetchData() async{
    await RoomController.instance.getRoomList();
    print("RoomList.Length :  ${RoomController.instance.roomList.length}");
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
                  textStyle: TextStyle(color: Colors.black)
                ),
              ),
            ),
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black87),
          ),
        ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(0,20,0,10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  child: Icon(Icons.location_on_outlined),
                ),
                SizedBox(width: 20,),
                Container(
                  child: Text("인천광역시 미추홀구 주부토로 201", style: GoogleFonts.notoSans(),),
                )
              ],
            ),
            SizedBox(height: 10,),

            Expanded(
              child: Obx(() => GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5
                ),
                itemCount: RoomController.instance.roomList.length,
                itemBuilder: (context, index){
                  return Container(
                      child: RoomTile(room: RoomController.instance.roomList[index]),

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
