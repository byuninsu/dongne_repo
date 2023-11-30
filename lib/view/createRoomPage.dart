import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateRoomPage extends StatefulWidget {
  const CreateRoomPage({Key? key}) : super(key: key);

  @override
  State<CreateRoomPage> createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {

  var formKey = GlobalKey<FormState>();

  var roomNameController = TextEditingController();
  var roomPasswordController = TextEditingController();
  var firstOptionController = TextEditingController();
  var firstOptionDescriptionController = TextEditingController();
  var secondOptionController = TextEditingController();
  var secondOptionDescriptionController = TextEditingController();


  String selectedDropdown = '치킨';

  var currentValue = '1 menu';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "방만들기",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
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
                  child: const Text(
                    "방 제목",
                    style: TextStyle(fontSize: 12),
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
                    padding:
                    EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextFormField(
                      controller: roomNameController,
                      validator: (val) =>
                      val == "" ? "방제목을 입력해주세요" : null,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '00동 치킨드실분 ?'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),


            ],
          ),
        ),
      ),
    );
  }
}
