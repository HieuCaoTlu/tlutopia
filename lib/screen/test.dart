import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController studentNameController = TextEditingController();
  TextEditingController studentCodeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: studentNameController,
              decoration: const InputDecoration(labelText: 'Student Name'),
            ),
            TextField(
              controller: studentCodeController,
              decoration: const InputDecoration(labelText: 'Student Code'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                registerUser();
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    var url = Uri.parse('http://tlu-booklending.mooo.com/api/users');
    var data = {
      'student_name': studentNameController.text,
      'student_code': studentCodeController.text,
      'phone': phoneController.text,
      'email': emailController.text,
      'password': passwordController.text,
    };

    try {
      var response = await http.post(url, body: data);

      if (response.statusCode == 201) {
        // Đăng ký thành công
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User registration successful'),
          ),
        );
      } else {
        // Đăng ký thất bại, hiển thị lỗi
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to register user. Status code: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      // Xử lý lỗi kết nối
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }
}

void main() {
  runApp(const MaterialApp(
    home: RegistrationScreen(),
  ));
}
