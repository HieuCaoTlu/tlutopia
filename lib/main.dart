// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tlutopia/model/cart.dart';
import 'package:tlutopia/model/schedule.dart';
import 'package:tlutopia/model/user.dart';
import 'screen/login/login.dart';

void main() async {
  await initializeDateFormatting('vi_VN', null);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return User(
      child: Schedule(
        child: Cart(
          child: MaterialApp(
            theme: ThemeData(fontFamily: 'PlusJakartaSans'),
            debugShowCheckedModeBanner: false,
            home: const Scaffold(
              body: LoginScreen(),
            ),
          ),
        ),
      ),
    );
  }
}
