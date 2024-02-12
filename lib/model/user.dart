// ignore_for_file: non_constant_identifier_names, must_be_immutable
import 'package:flutter/material.dart';

class User extends InheritedWidget {
  int user_id;
  String student_name;
  String student_code;
  String phone;
  String email;
  String status;

  User({
    this.user_id = -1,
    this.student_name = 'Unknown',
    this.student_code = '000',
    this.phone = '000',
    this.email = '0@gmail.com',
    this.status = 'Bình thường',
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  static User? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<User>();
  }

  @override
  bool updateShouldNotify(User oldWidget) {
    return true;
  }

  static User ofNonNull(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<User>();
    assert(provider != null, 'Không tìm thấy đối tượng');
    return provider!;
  }
}
