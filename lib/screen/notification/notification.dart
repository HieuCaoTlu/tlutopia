import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'notiCard.dart';
import 'notiInfo.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with AutomaticKeepAliveClientMixin {
  List<NotificationInformation> data = [];
  bool isLoading = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse('http://tlu-booklending.cloudns.be/api/notifications/');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var info = json.decode(response.body);
      for (var item in info) {
        data.add(NotificationInformation(
            "Thông báo ngày ${item['date_created']}",
            item['user_id'],
            item['content']));
      }
      setState(() {
        isLoading = false;
      });
    } else {
      print('Request failed with status');
      setState(() {
        isLoading = false;
      });
    }
  }

  void clearAllNotifications() {
    setState(() {
      data.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Image(image: AssetImage('assets/images/bg2.png')),
              ),
              Container(
                margin:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.07),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Thông báo",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w700),
                        ),
                        if (data.isNotEmpty)
                          TextButton(
                            style: const ButtonStyle(
                              shadowColor:
                                  MaterialStatePropertyAll(Colors.transparent),
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xffECECEC)),
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
                      ],
                    ),
                    if (isLoading)
                      const CircularProgressIndicator()
                    else if (data.isEmpty)
                      const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Divider(
                              height: 25,
                              color: Colors.transparent,
                            ),
                            Text(
                              "Không có thông báo",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      )
                    else
                      for (var item in data) NotificationCard(item),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
