import 'package:flutter/material.dart';
import 'package:tlutopia/screen/flow_screen.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({super.key});

  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  TextEditingController studentCode = TextEditingController();
  TextEditingController studentPass = TextEditingController();

  void Login() {
    String code = studentCode.text;
    String pass = studentPass.text;

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FlowScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 60)),
          const Image(image: AssetImage('assets/images/logo.png')),
          Container(
            width: double.infinity,
            // color: Colors.amber,
            alignment: Alignment.center,
            child: const Text(
              "Chào mừng",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
              width: double.infinity,
              // color: Colors.amber,
              alignment: Alignment.center,
              child: const Text(
                "đến thư viện số Thăng Long",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              )),
          Container(
              width: double.infinity,
              // color: Colors.lightBlue,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: studentCode,
                      decoration: const InputDecoration(
                        hintText: 'Mã sinh viên',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        contentPadding: EdgeInsets.all(16),
                        fillColor: Color(0xffEFEFEF),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                    child: TextField(
                      enableSuggestions: false,
                      autocorrect: false,
                      obscureText: true,
                      controller: studentPass,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'Mật khẩu',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        contentPadding: EdgeInsets.all(16),
                        fillColor: Color(0xffEFEFEF),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: ElevatedButton(
                          onPressed: () => {Login()},
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xffDAEBFF)),
                              maximumSize:
                                  MaterialStatePropertyAll(Size(300, 500)),
                              shadowColor:
                                  MaterialStatePropertyAll(Colors.transparent)),
                          child: const Text(
                            'Đăng nhập',
                            style: TextStyle(
                              color: Color(0xff3184FF),
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Chưa có tài khoản?",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // Text(
                        //   "Đăng kí",
                        //   style: TextStyle(
                        //       fontSize: 20,
                        //       fontWeight: FontWeight.w500,
                        //       color: Color(0xff3184FF)),
                        // ),
                        ElevatedButton(
                          onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ))
                          },
                          style: const ButtonStyle(
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.only(left: 10)),
                            shadowColor:
                                MaterialStatePropertyAll(Colors.transparent),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white),
                            overlayColor:
                                MaterialStatePropertyAll(Colors.white),
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.transparent),
                            surfaceTintColor:
                                MaterialStatePropertyAll(Colors.white),
                          ),
                          child: const Text(
                            "Đăng kí",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff3184ff),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    alignment: Alignment.bottomLeft,
                    image: AssetImage('assets/images/bg.png'),
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController studentCode = TextEditingController();
  TextEditingController studentName = TextEditingController();
  TextEditingController studentPass = TextEditingController();
  TextEditingController studentRePass = TextEditingController();
  TextEditingController studentPhoneNum = TextEditingController();
  TextEditingController studentEmail = TextEditingController();

  void goToDashboard() {
    String code = studentCode.text;
    String pass = studentPass.text;

    setState(() {});

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FlowScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        color: Colors.transparent,
        child: Column(children: [
          const Divider(
            height: 100,
            color: Colors.transparent,
          ),
          const Image(image: AssetImage('assets/images/logo.png')),
          const Text(
            "Tạo tài khoản",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: TextField(
              controller: studentCode,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'Mã sinh viên',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                contentPadding: EdgeInsets.all(16),
                fillColor: Color(0xffEFEFEF),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: TextField(
              controller: studentName,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'Tên sinh viên',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                contentPadding: EdgeInsets.all(16),
                fillColor: Color(0xffEFEFEF),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: TextField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              controller: studentPass,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'Mật khẩu: (tối thiểu 8 ký tự)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                contentPadding: EdgeInsets.all(16),
                fillColor: Color(0xffEFEFEF),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: TextField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              controller: studentRePass,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'Nhập lại mật khẩu: ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                contentPadding: EdgeInsets.all(16),
                fillColor: Color(0xffEFEFEF),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: TextField(
              controller: studentEmail,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'Nhập số điện thoại: ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                contentPadding: EdgeInsets.all(16),
                fillColor: Color(0xffEFEFEF),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: TextField(
              controller: studentPhoneNum,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Nhập số điện thoại: ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                contentPadding: EdgeInsets.all(16),
                fillColor: Color(0xffEFEFEF),
              ),
            ),
          ),
          const Divider(
            height: 30,
            color: Colors.transparent,
          ),
          const SizedBox(
            width: 300,
            child: Text(
              "Nhấp vào đăng kí là bạn đã đồng ý với điều khoản của TLUtopia",
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 200,
            height: 70,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: ElevatedButton(
                  onPressed: () => {goToDashboard()},
                  style: const ButtonStyle(
                      shadowColor: MaterialStatePropertyAll(Colors.transparent),
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xffDAEBFF)),
                      maximumSize: MaterialStatePropertyAll(Size(300, 500))),
                  child: const Text(
                    'Đăng kí',
                    style: TextStyle(
                      color: Color(0xff3184FF),
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}
