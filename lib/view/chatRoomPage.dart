import 'package:dongne/model/room.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({Key? key, required this.choiceRoom}) : super(key: key);

  final Room choiceRoom;

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {

  var chatContainController = TextEditingController();


  String getRemainTime(){
    DateTime settingTime = DateTime.parse(widget.choiceRoom.dueDate);

    DateTime nowTime = DateTime.now();

    Duration difference = settingTime.difference(nowTime);

    StringBuffer dueTime = StringBuffer();

    dueTime.write("${difference.inHours.toString()} 시간 ");
    dueTime.write("${difference.inMinutes.toString()} 분 남았어요!");

    return dueTime.toString();
  }


  @override
  void initState() {
    super.initState();

    getRemainTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //앱 바의 높이를 지정한다.
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          title: Center(
            child: Text(widget.choiceRoom.title,
                style: GoogleFonts.notoSans(
                    textStyle: TextStyle(color: Colors.black))),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black87),
        ),
      ),
      body: Container(
        width: 350,
        height: 600,
        child: Column(
          children: [
            Container(
              width: 350,
              height: 50,
              color: Colors.grey,
              child: Center(
                child: Text(getRemainTime())
              ),
            ),
            Container(
              width: 350,
              height: 100,
              child: Column(
                children: [
                  Text(" '배달의 민족' '함께주문' 링크"),
                  Text(widget.choiceRoom.orderLink),
                ],
              ),
            ),
            Container(
              width: 350,
              height: 400,
              child: SingleChildScrollView(


              ),
            ),
            Row(
              children: [
                Container(
                  width: 300,
                  height: 50,
                  child: TextFormField(
                    controller: chatContainController,
                    validator: (val) => val == "" ? "채팅내용을 입력해주세요" : null,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: '채팅을 입력해보세요 !'),
                  ),
                ),
                IconButton(onPressed: (){

                }, icon: Icon(Icons.send))
              ],
            )

          ],
        ),
      ),

    );
  }
}
