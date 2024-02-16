// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tlutopia/model/cart.dart';
import 'package:tlutopia/model/schedule.dart';
import 'package:tlutopia/model/user.dart';
import 'package:tlutopia/screen/flow.dart';
import 'screen/login/login.dart';
import 'package:flutter/services.dart';

void main() async {
  await initializeDateFormatting('vi_VN', null);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
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
            onGenerateRoute: (settings) {
              if (settings.name == '/flow') {
                return MaterialPageRoute(
                  builder: (context) => const FlowScreen(),
                );
              }
              return MaterialPageRoute(
                builder: (context) => const ErrorPage(),
              );
            },
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

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
