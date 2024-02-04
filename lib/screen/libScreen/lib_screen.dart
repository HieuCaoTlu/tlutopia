import 'package:flutter/material.dart';
import 'package:tlutopia/object/Cart.dart';
import 'cart_fragment.dart';
import 'library_fragment.dart';
import 'search_fragment.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final Cart cart = Cart();
  int _selectedIndex = 0;
  List<Widget> get _widgetOptions => [
        LibraryFragment(cart),
        SearchFragment(cart),
        CartFragment(cart),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
            label: 'Thư viện',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search_rounded,
              size: 30,
            ),
            label: 'Tìm kiếm',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_bag_rounded,
              size: 30,
            ),
            label: 'Giỏ hàng',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff3788FF),
        onTap: _onItemTapped,
      ),
    );
  }
}
