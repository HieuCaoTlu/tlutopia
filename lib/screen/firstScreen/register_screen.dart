import 'package:flutter/material.dart';
import 'package:tlutopia/screen/flow_screen.dart';
import 'package:http/http.dart' as http;

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
  bool success = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
            InputField(
              controller: studentCode,
              description: 'Mã sinh viên',
              hideText: false,
            ),
            InputField(
                controller: studentName,
                description: 'Tên sinh viên',
                hideText: false),
            InputField(
                controller: studentEmail,
                description: 'Nhập email: ',
                hideText: false),
            InputField(
                controller: studentPhoneNum,
                description: 'Nhập số điện thoại: ',
                hideText: false),
            InputField(
                controller: studentPass,
                description: 'Mật khẩu: (tối thiểu 8 ký tự)',
                hideText: true),
            InputField(
                controller: studentRePass,
                description: 'Nhập lại mật khẩu: ',
                hideText: true),
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
                    onPressed: () => {fetchData(), if (success) goToDashboard()},
                    style: const ButtonStyle(
                      shadowColor: MaterialStatePropertyAll(Colors.transparent),
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xffDAEBFF)),
                    ),
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
      ),
    );
  }

  Future<void> fetchData() async {
    if (studentPass.text != studentRePass.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mật khẩu nhập lại không khớp'),
        ),
      );
      return;
    }
    if (studentCode.text.isEmpty ||
        studentPass.text.isEmpty ||
        studentName.text.isEmpty ||
        studentPhoneNum.text.isEmpty ||
        studentEmail.text.isEmpty) {
      // Display an error message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập toàn bộ thông tin.'),
        ),
      );
      return;
    }

    success = true;
    var url = Uri.parse('http://192.168.1.10/aserver/register.php');
    var data = {
      'studentCode': studentCode.text,
      'studentPass': studentPass.text,
      'studentName': studentName.text,
      'studentPhoneNum': studentPhoneNum.text,
      'studentEmail': studentEmail.text,
    };

    try {
      var response = await http.post(url, body: data);

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.body),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to load data. Status code: ${response.statusCode}'),
          ),
        );
      }
    } catch (error) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }

  void goToDashboard() {
    setState(() {});
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FlowScreen(studentName: studentName.text, studentCode: studentCode.text, studentPhoneNum: studentPhoneNum.text),
        ));
  }
}

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.controller,
    required this.description,
    required this.hideText,
  });

  final TextEditingController controller;
  final String description;
  final bool hideText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
      child: TextField(
        autocorrect: false,
        enableSuggestions: false,
        obscureText: hideText,
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: description,
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
    );
  }
}
