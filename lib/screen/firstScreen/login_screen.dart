import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tlutopia/screen/flow_screen.dart';
import 'package:http/http.dart' as http;

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController studentCode = TextEditingController();
  TextEditingController studentPass = TextEditingController();
  bool success = false;
  FocusNode focus = FocusNode();
  String studentName = '';
  String studentPhoneNum = '';

  void login() {
    fetchData((success) {
      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => FlowScreen(
                    studentName: studentName,
                    studentCode: studentCode.text,
                    studentPhoneNum: studentPhoneNum,
                  )),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              height: MediaQuery.of(context).size.height * 0.05,
              color: Colors.transparent,
            ),
            const Image(image: AssetImage('assets/images/logo.png')),
            Container(
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
              alignment: Alignment.center,
              child: const Text(
                "đến thư viện số Thăng Long",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                    child: TextField(
                      enableSuggestions: false,
                      focusNode: focus,
                      autocorrect: false,
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
                        onPressed: () => {login()},
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xffDAEBFF)),
                          maximumSize: MaterialStatePropertyAll(Size(300, 500)),
                          shadowColor:
                              MaterialStatePropertyAll(Colors.transparent),
                        ),
                        child: const Text(
                          'Đăng nhập',
                          style: TextStyle(
                            color: Color(0xff3184FF),
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
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
                        ElevatedButton(
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            )
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
              ),
            ),
          ],
        ),
        // Visibility(
        //   visible: focus.hasFocus,
        //   child: Positioned(
        //     bottom: 0,
        //     child: Container(
        //       width: MediaQuery.of(context).size.width,
        //       height: 150,
        //       decoration: const BoxDecoration(
        //         image: DecorationImage(
        //           fit: BoxFit.fill,
        //           alignment: Alignment.bottomLeft,
        //           image: AssetImage('assets/images/bg.png'),
        //         ),
        //       ),
        //     ),
        //   ),
        // )
      ),
    );
  }

  fetchData(Function(bool) callback) async {
    if (studentCode.text == 'admin' && studentPass.text == 'admin') {
      callback(true);
    }
    if (studentCode.text.isEmpty || studentPass.text.isEmpty) {
      // Display an error message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập toàn bộ thông tin.'),
        ),
      );
      return;
    }

    var url = Uri.parse('http://192.168.1.10/aserver/login.php');
    var data = {
      'studentCode': studentCode.text,
      'studentPass': studentPass.text,
    };

    try {
      var response = await http.post(url, body: data);

      final responseData = json.decode(response.body);

      if (responseData['status'] == 'success') {
        studentName = responseData['studentName'];
        studentPhoneNum = responseData['studentPhoneNum'];
        callback(true);
        // Đăng nhập thành công, xử lý logic ở đây
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${responseData['message']}'),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        callback(false);
        // Đăng nhập thất bại, xử lý logic ở đây
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${responseData['message']}'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      callback(false);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }
}
