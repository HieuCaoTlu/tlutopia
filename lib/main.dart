import 'package:flutter/material.dart';
import 'package:tlutopia/screen/libScreen/lib_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting('vi_VN', null);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'PlusJakartaSans'),
      debugShowCheckedModeBanner: false,
      home: const LibraryScreen(),
    );
  }
}
