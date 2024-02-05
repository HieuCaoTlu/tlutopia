import 'package:flutter/widgets.dart';

class UserProvider extends InheritedWidget {
  int user_id;
  String studentCode;
  String studentName;
  String studentPhoneNum;

  UserProvider({
    required this.user_id,
    required this.studentCode,
    required this.studentName,
    required this.studentPhoneNum,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  static UserProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserProvider>();
  }

  @override
  bool updateShouldNotify(UserProvider oldWidget) {
    return true;
  }

  static UserProvider ofNonNull(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<UserProvider>();
    assert(provider != null, 'No UserProvider found in context');
    return provider!;
  }
}
