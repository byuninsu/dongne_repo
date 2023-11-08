import 'package:flutter/material.dart';
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


  @override
  Widget build(BuildContext context) {
    double phoneWidthSize = MediaQuery.of(context).size.width - 5;
    double phoneHeightSize = MediaQuery.of(context).size.height - 5;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                SizedBox(height: 20),
                Text(
                  "우리 Dongne",
                  style: GoogleFonts.bebasNeue(fontSize: 30.0),
                ),
                SizedBox(height: 10),
                Text("모일수록 이득보는 우리동네",
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 30,
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
                              controller: emailController,
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
                    if(formKey.currentState!.validate()){

                    }
                  },
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.red,
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
                      onPressed: () {},
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
                      onPressed: () {},
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
                SizedBox(
                  height: 10,
                ),
                SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child:
                        TextButton(
                          onPressed: (){},
                          child: Text("회원가입", style: TextStyle(color: Colors.black87,)),
                        )
                    ),
                    SizedBox(width: 50,),
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
