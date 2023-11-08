import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var formKey = GlobalKey<FormState>();

  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var checkPasswordController = TextEditingController();
  var addressController = TextEditingController();

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
          title: Row(
            children: [
              SizedBox(width: phoneWidthSize/4.2,),
              Text(
                "회원가입",
                style: TextStyle(color: Colors.black87),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black87),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text('모이면 저렴해진다 ~  우리 Dongne',
                      style: GoogleFonts.bebasNeue(fontSize: 18)),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
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
                      Padding(
                        padding: EdgeInsets.only(left: phoneWidthSize / 19.35),
                        child: Row(
                          children: [
                            Container(
                              width: phoneWidthSize / 1.5,
                              height: phoneHeightSize / 15.96,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: phoneWidthSize / 19.35),
                                child: TextFormField(
                                  controller: emailController,
                                  validator: (val) =>
                                      val == "" ? "이메일을 입력해주세요" : null,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'abcd@naver.com'),
                                ),
                              ),
                            ),
                            SizedBox(width: 5,),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: OutlinedButton(
                                onPressed: () {},
                                child: Text("중복확인", style: TextStyle(color: Colors.black87),),
                              ),
                            )
                          ],
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
                                border: InputBorder.none,
                                hintText: '영문, 숫자 포함 8자 이상'),
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
                          "비밀번호 재확인",
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
                            controller: checkPasswordController,
                            validator: (val) =>
                                val == "" ? "비밀번호를 입력해주세요" : null,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '위와 같이 입력해주세요'),
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
                          "닉네임",
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: phoneWidthSize / 19.35),
                        child: Row(
                          children: [
                            Container(
                              width: phoneWidthSize / 1.5,
                              height: phoneHeightSize / 15.96,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: phoneWidthSize / 19.35),
                                child: TextFormField(
                                  controller: userNameController,
                                  validator: (val) =>
                                  val == "" ? "닉네임을 입력해주세요" : null,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '한글 또는 영문 6자 이하'),
                                ),
                              ),
                            ),
                            SizedBox(width: 5,),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: OutlinedButton(
                                onPressed: () {},
                                child: Text("중복확인", style: TextStyle(color: Colors.black87),),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: phoneWidthSize / 1.1,
                        height: phoneHeightSize / 39.9,
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "주소",
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
                            controller: addressController,
                            validator: (val) => val == "" ? "주소를 입력해주세요" : null,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '서울특별시 00구 00동'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {}
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
                            '  가입하기',
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
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('이미 회원이라면?'),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Text(
                        '  로그인 화면으로',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
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
