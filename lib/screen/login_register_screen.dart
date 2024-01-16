import 'package:flutter/material.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({super.key});

  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( // khung xương của màn hình
      appBar: AppBar( // biểu ngữ của màn hình
        title: const Text("Login Register Screen"),),
      body: Column( // biểu diễn các phần tử theo chiều dọc
        children: [
          Container( // giá đỡ phổ biến cho các phần tử
              width: double.infinity,
              alignment: Alignment.center,
              color: Colors.blue,
              child: const Text(
                'Nội dung',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
              ),
            )
        ],
      ),
    );
  }
}
