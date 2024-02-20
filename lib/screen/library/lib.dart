import 'package:flutter/material.dart';
import 'package:tlutopia/model/cart.dart';
import 'package:tlutopia/model/schedule.dart';
import 'package:tlutopia/screen/library/libFragment.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => LibraryScreenState();
}

class LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    Cart cart = Cart.ofNonNull(context);
    Schedule schedule = Schedule.ofNonNull(context);
    cart.getProhibitedBooks(schedule);
    return const Scaffold(body: LibraryFragment());
  }
}
