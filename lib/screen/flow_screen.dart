import 'package:flutter/material.dart';
import 'package:tlutopia/screen/accScreen/acc_screen.dart';
import 'package:tlutopia/screen/homeScreen/home_screen.dart';
import 'package:tlutopia/screen/libScreen/lib_screen.dart';
import 'package:tlutopia/screen/notiScreen/noti_screen.dart';
import 'package:tlutopia/screen/scheduleScreen/sch_screen.dart';

class FlowScreen extends StatefulWidget {
  final String studentName;
  final String studentCode;
  final String studentPhoneNum;
  const FlowScreen({required this.studentName, required this.studentCode, required this.studentPhoneNum, Key? key}) : super(key: key);

  @override
  State<FlowScreen> createState() => _FlowScreenState();
}

class _FlowScreenState extends State<FlowScreen> {
  int _selectedIndex = 0;
  List<Widget> get _widgetOptions => [
        HomeScreen(name: widget.studentName),
        const ScheduleScreen(),
        const NotifyScreen(),
        AccountScreen(studentName: widget.studentName, studentCode: widget.studentCode, studentPhoneNum: widget.studentPhoneNum),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String getStudentName() {
    return widget.studentName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 25,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
              size: 30,
            ),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_view_day_rounded,
              size: 25,
            ),
            label: 'Lịch hẹn',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_rounded,
              size: 25,
            ),
            label: 'Thông báo',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_rounded,
              size: 30,
            ),
            label: 'Cá nhân',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff3788FF),
        onTap: _onItemTapped,
      ),
    );
  }
}
