// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tlutopia/model/cart.dart';
import 'package:tlutopia/model/schedule.dart';
import 'package:tlutopia/model/user.dart';
import 'package:tlutopia/screen/flow.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController code = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController repass = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  bool success = false;
  bool isLoading = false;

  void login() async {
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng kí thành công'),
          duration: Duration(milliseconds: 500),
        ),
      );
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                settings: const RouteSettings(name: "/flow"),
                builder: (context) => const FlowScreen()));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng kí thất bại'),
          duration: Duration(milliseconds: 500),
        ),
      );
    }
  }

  Future<void> register() async {
    setState(() {
      isLoading = true;
    });
    await fetchData();
    setState(() {
      isLoading = false;
    });
    login();
  }

  fetchData() async {
    final User user = User.ofNonNull(context);
    final Cart cart = Cart.ofNonNull(context);
    final Schedule schedule = Schedule.ofNonNull(context);
    if (code.text.isEmpty ||
        pass.text.isEmpty ||
        name.text.isEmpty ||
        repass.text.isEmpty ||
        phone.text.isEmpty ||
        email.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập toàn bộ thông tin.'),
          duration: Duration(milliseconds: 500),
        ),
      );
      return;
    }
    if (pass.text != repass.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mật khẩu và xác nhận mật khẩu không đúng'),
          duration: Duration(milliseconds: 500),
        ),
      );
      return;
    }
    if (pass.text.length < 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mật khẩu phải tối thiểu 5 kí tự'),
          duration: Duration(milliseconds: 500),
        ),
      );
      return;
    }

    var url = Uri.parse('http://tlu-booklending.cloudns.be/api/users');
    var data = {
      'student_name': name.text,
      'student_code': code.text,
      'phone': phone.text,
      'email': email.text,
      'password': pass.text,
    };

    try {
      var response = await http.post(url, body: data);
      final Map<String, dynamic> info = json.decode(response.body);
      if (info['id'] != null) {
        user.user_id = info['id'];
        user.student_code = info['student_code'];
        user.student_name = info['student_name'];
        user.phone = info['phone'];
        user.email = info['email'];
        setState(() {
          schedule.update(user.user_id);
          cart.list.clear();
          cart.prohibited.clear();
          success = true;
        });
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                Divider(
                  height: MediaQuery.of(context).size.height * 0.05,
                  color: Colors.transparent,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () => {Navigator.pop(context)},
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.fromLTRB(10, 0, 10, 0)),
                      shadowColor: MaterialStatePropertyAll(Colors.transparent),
                      overlayColor: MaterialStatePropertyAll(Colors.white),
                      foregroundColor:
                          MaterialStatePropertyAll(Colors.transparent),
                      surfaceTintColor: MaterialStatePropertyAll(Colors.white),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.arrow_back_ios_rounded,
                            size: 18,
                            color: Color.fromARGB(255, 116, 116, 116)),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Tôi đã có tài khoản",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 116, 116, 116),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: MediaQuery.of(context).size.height * 0.05,
                  color: Colors.transparent,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(image: AssetImage('assets/images/logo.png')),
                    const Text(
                      "Tạo tài khoản",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(30),
                      child: Column(children: [
                        InputField(
                          controller: code,
                          placeholder: "Mã sinh viên",
                        ),
                        InputField(
                          controller: name,
                          placeholder: "Tên sinh viên",
                        ),
                        InputField(
                          controller: pass,
                          placeholder: "Mật khẩu (tối thiểu 5 kí tự):",
                          hide: true,
                        ),
                        InputField(
                          controller: repass,
                          placeholder: "Xác nhận mật khẩu: ",
                          hide: true,
                        ),
                        InputField(
                          controller: phone,
                          placeholder: "Số điện thoại:",
                        ),
                        InputField(
                          controller: email,
                          placeholder: "Email: ",
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: const Text(
                            "Nhấp vào đăng ký là bạn đã đồng ý với điều khoản của TLUtopia",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Divider(height: 20, color: Colors.transparent),
                        isLoading
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xff3184FF),
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height:
                                    MediaQuery.of(context).size.height * 0.063,
                                child: ElevatedButton(
                                  onPressed: () {
                                    register();
                                  },
                                  style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xffDAEBFF)),
                                    maximumSize: MaterialStatePropertyAll(
                                        Size(300, 500)),
                                    shadowColor: MaterialStatePropertyAll(
                                        Colors.transparent),
                                  ),
                                  child: const Text(
                                    'Đăng kí',
                                    style: TextStyle(
                                      color: Color(0xff3184FF),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                      ]),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class InputField extends StatelessWidget {
  InputField(
      {super.key,
      required this.controller,
      required this.placeholder,
      this.hide = false,
      FocusNode? focus})
      : focus = focus ?? FocusNode();

  final TextEditingController controller;
  final String placeholder;
  final bool hide;
  final FocusNode focus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          focusNode: focus,
          controller: controller,
          obscureText: hide,
          decoration: InputDecoration(
            hintText: placeholder,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            contentPadding: const EdgeInsets.all(16),
            fillColor: const Color(0xffEFEFEF),
          ),
        ),
        const Divider(
          height: 15,
          color: Colors.transparent,
        ),
      ],
    );
  }
}
