import 'dart:typed_data';

import 'package:dongne/controller/room_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/room.dart';

class RoomTile extends StatefulWidget {
  const RoomTile({Key? key, required this.room}) : super(key: key);

  final Room room;

  @override
  State<RoomTile> createState() => _RoomTileState();
}

class _RoomTileState extends State<RoomTile> {
  Uint8List firstOptionImage = Uint8List(0);
  Uint8List secondOptionImage = Uint8List(0);

  bool isDeadLine = false;

  @override
  void initState() {
    fetchData();
  }

  Future<void> fetchData() async {
    if (widget.room != null) {
      if (widget.room!.first_option_image != null) {
        firstOptionImage = Uint8List(widget.room!.first_option_image.length);
        firstOptionImage = widget.room!.first_option_image;
      }
      if (widget.room!.second_option_image != null) {
        secondOptionImage = Uint8List(widget.room!.second_option_image.length);
        secondOptionImage = widget.room!.second_option_image;
      }
    }

    print("firstoption  : ${widget.room.first_option_vote}");
    print("secondoption  : ${widget.room.second_option_vote}");

    if (widget.room.first_option_vote >= widget.room.second_option_vote) {
      setState(() {
        isDeadLine = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double phoneWidthSize = MediaQuery.of(context).size.width - 5;
    double phoneHeightSize = MediaQuery.of(context).size.height - 5;

    return Padding(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: Container(
        decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          shadows: [BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 6,
            offset: Offset(0,0),
            spreadRadius: 1
          )]
        ),

        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipOval(
                    child: SizedBox(
                        width: 40,
                        height: 40,
                        child: firstOptionImage.length > 0
                            ? Image.memory(
                                firstOptionImage!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset("images/chiken.png")),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: 120,
                      child: Text(
                        "${widget.room.room_name}",
                        style: GoogleFonts.notoSans(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold
                          )
                        ),
                      ),
                    ),
                    Container(
                      width: 120,
                      child: Text(
                        "${widget.room.second_option}",
                        style: GoogleFonts.notoSans(
                          textStyle: TextStyle(color: Colors.grey, fontSize: 12)
                        )
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                    child: Container(
                      width: 80,
                      height: 25,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: isDeadLine ? Colors.grey : Colors.red,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: isDeadLine
                            ? Text(
                                '마감',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                '모집중',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Icon(Icons.person),
                Container(
                  child: Text(
                      "${widget.room.first_option_vote} / ${widget.room.second_option_vote}"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}