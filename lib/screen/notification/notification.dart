import 'package:flutter/material.dart';
import 'package:tlutopia/model/noti.dart';
import 'notiCard.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  void clearAllNotifications(BuildContext context) {
    final center = NotiCenter.ofNonNull(context);
    setState(() {
      center.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final center = NotiCenter.ofNonNull(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
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
                        if (center.list.isNotEmpty)
                          TextButton(
                            style: const ButtonStyle(
                              shadowColor:
                                  MaterialStatePropertyAll(Colors.transparent),
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xffECECEC)),
                            ),
                            onPressed: () {
                              clearAllNotifications(context);
                            },
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
                    if (center.list.isEmpty)
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
                      for (var item in center.list) NotificationCard(item),
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
