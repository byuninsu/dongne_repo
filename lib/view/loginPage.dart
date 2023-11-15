import 'package:dongne/controller/user_controller.dart';
import 'package:dongne/model/userInfo.dart';
import 'package:dongne/view/mainPage.dart';
import 'package:dongne/view/menuPage.dart';
import 'package:dongne/view/signupPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool hasContent = false;
  bool hasContent2 = false;



  @override
  void initState() {
    super.initState();

    emailController.addListener(() {
      setState(() {
        hasContent = emailController.text.isNotEmpty;
      });
    });

    passwordController.addListener(() {
      setState(() {
        hasContent2 = passwordController.text.isNotEmpty;
      });
    });



  }


  @override
  Widget build(BuildContext context) {

    double phoneWidthSize = MediaQuery.of(context).size.width - 5;
    double phoneHeightSize = MediaQuery.of(context).size.height - 5;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          title: Center(
            child: Text(
              "로그인",
              style: TextStyle(color: Colors.black87),
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black87),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.accessibility,
                      size: 50,
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.add,
                      size: 40,
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.wc,
                      size: 50,
                    )
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "우리 Dongne",
                  style: GoogleFonts.bebasNeue(fontSize: 25.0),
                ),
                SizedBox(height: 5),
                Text("모일수록 이득보는 우리동네",
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 20,
                ),
                Form(
                    key:formKey,
                    child: Column(
                      children: [
                        Container(
                          width: phoneWidthSize / 1.1,
                          height: phoneHeightSize / 39.9,
                          alignment: Alignment.topLeft,
                          child: const Text(
                            "이메일",
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: phoneWidthSize / 1.1,
                          height: phoneHeightSize / 15.96,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding:
                            EdgeInsets.only(left: phoneWidthSize / 19.35),
                            child: TextFormField(
                              controller: emailController,
                              validator: (val) =>
                              val == "" ? "이메일을 입력해주세요" : null,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: 'adcd@naver.com'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: phoneWidthSize / 1.1,
                          height: phoneHeightSize / 39.9,
                          alignment: Alignment.topLeft,
                          child: const Text(
                            "비밀번호",
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: phoneWidthSize / 1.1,
                          height: phoneHeightSize / 15.96,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding:
                            EdgeInsets.only(left: phoneWidthSize / 19.35),
                            child: TextFormField(
                              controller: passwordController,
                              validator: (val) =>
                              val == "" ? "비밀번호를 입력해주세요" : null,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: '영문, 숫자 포함 8자 이상'),
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    // if(formKey.currentState!.validate()){
                    //
                    // }
                    Get.to(MenuPage());
                  },
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: hasContent && hasContent2 ? Colors.red : Colors.grey,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Text(
                            '로그인',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  child: Text("OR", style: TextStyle(fontSize: 15.0),),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: ButtonTheme(
                    height: 50.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                      onPressed: UserController.instance.signInWithGoogle,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'images/google.png',
                            width: 30,
                            height: 30,
                          ),
                          Text(
                            '구글계정으로 로그인',
                            style: TextStyle(color: Colors.black87, fontSize: 15.0),
                          ),
                          Opacity(
                            opacity: 0.0,
                            child: Image.asset(
                              'images/google.png',
                              width: 30,
                              height: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: ButtonTheme(
                    height: 50.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                      onPressed: () {
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'images/kakao.png',
                            width: 30,
                            height: 30,
                          ),
                          Text(
                            '카카오계정으로 로그인',
                            style: TextStyle(color: Colors.black87, fontSize: 15.0),
                          ),
                          Opacity(
                            opacity: 0.0,
                            child: Image.asset(
                              'images/kakao.png',
                              width: 30,
                              height: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: ButtonTheme(
                    height: 50.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700]),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'images/naver.png',
                            width: 30,
                            height: 30,
                          ),
                          Text(
                            '네이버계정으로 로그인',
                            style: TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                          Opacity(
                            opacity: 0.0,
                            child: Image.asset(
                              'images/naver.png',
                              width: 30,
                              height: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                  ),
                ),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child:
                        TextButton(
                          onPressed: (){
                            Get.to(SignupPage());
                          },
                          child: Text("회원가입", style: TextStyle(color: Colors.black87,)),
                        )
                    ),
                    SizedBox(width: 80,),
                    Container(
                      child:
                      TextButton(
                        onPressed: (){},
                        child: Text("아이디/비밀번호 찾기", style: TextStyle(color: Colors.black87)),
                      )
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
