import 'package:flutter/material.dart';
import 'package:tlutopia/object/Calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tlutopia/object/Schedule.dart';
import 'package:tlutopia/screen/firstScreen/login_screen.dart';

void main() async {
  await initializeDateFormatting('vi_VN', null);
  List<Schedule> sharedList = [];
  runApp(
    BookingCalendarProvider(
      list: sharedList,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        home: MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'PlusJakartaSans'),
      home: const LoginScreen(),
    );
  }
}
