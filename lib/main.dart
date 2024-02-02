import 'package:flutter/material.dart';
import 'package:tlutopia/screen/flow_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'PlusJakartaSans'),
      debugShowCheckedModeBanner: false,
      home: const FlowScreen(),
    );
  }
}

