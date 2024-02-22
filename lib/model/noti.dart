// ignore_for_file: must_be_immutable
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tlutopia/screen/notification/notiInfo.dart';

class NotiCenter extends InheritedWidget {
  List<NotificationInformation> list = [];

  NotiCenter({
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  static NotiCenter? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NotiCenter>();
  }

  @override
  bool updateShouldNotify(NotiCenter oldWidget) {
    return list != oldWidget.list;
  }

  static NotiCenter ofNonNull(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<NotiCenter>();
    assert(provider != null, 'Không tìm thấy đối tượng');
    return provider!;
  }

  Future<void> update() async {
    list.clear();
    var url = Uri.parse('http://tlu-booklending.cloudns.be/api/notifications/');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var info = json.decode(response.body);
      for (var item in info) {
        var temp = DateTime.parse(item['date_created']);
        list.add(NotificationInformation(
            "Thông báo ngày ${DateFormat('dd/MM', 'vi_VN').format(temp)}",
            item['user_id'].toString(),
            item['content']));
      }
      print(list.length);
    } else {
      print('Request failed with status');
    }
  }

  void clear() {
    list.clear();
  }
}
