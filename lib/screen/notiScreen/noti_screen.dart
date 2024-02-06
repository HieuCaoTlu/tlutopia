import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'notification_card.dart';

class NotifyScreen extends StatefulWidget {
  const NotifyScreen({super.key});

  @override
  State<NotifyScreen> createState() => _NotifyScreenState();
}

class _NotifyScreenState extends State<NotifyScreen> {
  List<NotificationInformation> data = [];
  @override
  void initState() {
    super.initState();
    data = [];
    // fetchData();
  }

  List<NotificationInformation> convertMapToList(Map<String, dynamic> data) {
    List<NotificationInformation> list = [];
    data.forEach((key, value) {
      for (int i = 0; i < value.length; i++) {
        list.add(NotificationInformation(
            value[i]['title'], value[i]['source'], value[i]['description']));
      }
    });
    return list;
  }

  Future<void> fetchData() async {
    // Gửi yêu cầu GET đến server
    var url = Uri.parse('');
    var response = await http.get(url);

    // Kiểm tra xem yêu cầu có thành công không (status code 200)
    if (response.statusCode == 200) {
      // Chuyển đổi dữ liệu JSON thành danh sách đối tượng
      final Map<String, dynamic> jsonData = json.decode(response.body);
      setState(() {
        data = convertMapToList(jsonData);
      });
    } else {
      // Xử lý lỗi nếu có
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 150,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              alignment: Alignment.bottomLeft,
              image: AssetImage('assets/images/bg2.png'),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              "Thông báo",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return NotificationCard(data[index]);
            },
          ),
        ),
        if (data.isNotEmpty)
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(40, 80, 40, 0),
            child: ElevatedButton(
              style: const ButtonStyle(
                shadowColor: MaterialStatePropertyAll(Colors.transparent),
                backgroundColor: MaterialStatePropertyAll(Color(0xffECECEC)),
              ),
              onPressed: clearAllNotifications,
              child: const Text(
                'Xóa tất cả',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
      ]),
    );
  }

  void clearAllNotifications() {
    setState(() {
      data.clear();
    });
  }
}

class NotificationInformation {
  final String title;
  final String source;
  final String description;

  NotificationInformation(this.title, this.source, this.description);

  String getTitle() {
    return title;
  }

  String getSource() {
    return source;
  }

  String getDescription() {
    return description;
  }
}
