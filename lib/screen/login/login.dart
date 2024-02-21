// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tlutopia/model/schedule.dart';
import 'package:tlutopia/model/user.dart';
import 'package:tlutopia/model/cart.dart';
import 'package:tlutopia/screen/flow.dart';
import 'package:tlutopia/screen/login/register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController code = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool isLoading = false;
  bool success = false;

  void login() async {
    setState(() {
      isLoading = true;
    });
    await fetchData();
    setState(() {
      isLoading = false;
    });
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng nhập thành công'),
          duration: Duration(milliseconds: 500),
        ),
      );
      Future.delayed(const Duration(milliseconds: 600), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                settings: const RouteSettings(name: "/flow"),
                builder: (context) => const FlowScreen()));
      });
    }
  }

  void register() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const RegisterScreen()));
  }

  fetchData() async {
    final User user = User.ofNonNull(context);
    final Schedule schedule = Schedule.ofNonNull(context);
    final Cart cart = Cart.ofNonNull(context);
    if (code.text == 'admin' && pass.text == 'admin') {
      user.student_name = "Admin";
      return;
    }
    if (code.text.isEmpty || pass.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập toàn bộ thông tin.'),
          duration: Duration(milliseconds: 500),
        ),
      );
      return;
    }

    var url = Uri.parse('http://tlu-booklending.cloudns.be/api/login');
    var data = {
      'student_code': code.text,
      'password': pass.text,
    };

    try {
      var response = await http.post(url, body: data);
      final info = json.decode(response.body);
      if (!info.containsKey("id")) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sai thông tin đăng nhập'),
            duration: Duration(milliseconds: 500),
          ),
        );
        return;
      } else {
        user.user_id = info['id'];
        user.student_code = info['student_code'];
        user.student_name = info['student_name'];
        user.phone = info['phone'];
        user.email = info['email'];
        await schedule.update(user.user_id);
        cart.list.clear();
        cart.prohibited.clear();
        success = true;
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Không thể kết nối đến máy chủ. Lỗi: $error'),
          duration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Divider(
                  height: MediaQuery.of(context).size.height * 0.15,
                  color: Colors.transparent,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('assets/images/logo.png')),
                    Text(
                      "Chào mừng",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "đến thư viện số Thăng Long",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      TextField(
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.text,
                        controller: code,
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
                      const Divider(
                        height: 15,
                        color: Colors.transparent,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.063,
                            child: TextField(
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              keyboardType: TextInputType.text,
                              controller: pass,
                              decoration: const InputDecoration(
                                hintText: 'Mật khẩu',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
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
                          isLoading
                              ? SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0xff3184FF),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: MediaQuery.of(context).size.height *
                                      0.063,
                                  child: ElevatedButton(
                                    onPressed: () => {login()},
                                    style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Color(0xffDAEBFF)),
                                      maximumSize: MaterialStatePropertyAll(
                                          Size(300, 500)),
                                      shadowColor: MaterialStatePropertyAll(
                                          Colors.transparent),
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
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
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
                      onPressed: () => {register()},
                      style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(
                            EdgeInsets.fromLTRB(10, 0, 10, 0)),
                        shadowColor:
                            MaterialStatePropertyAll(Colors.transparent),
                        backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                        overlayColor: MaterialStatePropertyAll(Colors.transparent),
                        foregroundColor:
                            MaterialStatePropertyAll(Colors.transparent),
                        surfaceTintColor:
                            MaterialStatePropertyAll(Colors.transparent),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
