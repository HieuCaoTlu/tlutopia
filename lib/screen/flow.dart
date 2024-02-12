import 'package:flutter/material.dart';
import 'package:tlutopia/screen/home/home.dart';
import 'package:tlutopia/screen/notification/notification.dart';
import 'package:tlutopia/screen/personal/personal.dart';
import 'package:tlutopia/screen/schedule/schedule.dart';

class FlowScreen extends StatefulWidget {
  const FlowScreen({super.key});

  @override
  FlowScreenState createState() => FlowScreenState();
}

class FlowScreenState extends State<FlowScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        children: const <Widget>[
          HomeScreen(),
          ScheduleScreen(),
          NotificationScreen(),
          PersonalScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: const Color(0xff3788FF),
        currentIndex: _currentPageIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
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
      ),
    );
  }
}