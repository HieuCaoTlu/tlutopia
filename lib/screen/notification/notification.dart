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
  bool isLoading = false;

  @override
  bool get wantKeepAlive => true;

  void updateNotification(BuildContext context) async {
    final center = NotiCenter.ofNonNull(context);
    setState(() {
      isLoading = true;
    });
    await center.update();
    setState(() {
      isLoading = false;
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
                        TextButton(
                          style: const ButtonStyle(
                            shadowColor:
                                MaterialStatePropertyAll(Colors.transparent),
                            backgroundColor:
                                MaterialStatePropertyAll(Color(0xffECECEC)),
                          ),
                          onPressed: () {
                            updateNotification(context);
                          },
                          child: const Text(
                            'Cập nhật',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    isLoading
                        ? Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Divider(
                                    height: 25,
                                    color: Colors.transparent,
                                  ),
                                  CircularProgressIndicator(
                                    color: Color(0xff3184FF),
                                  ),
                                  Divider(
                                    height: 10,
                                    color: Colors.transparent,
                                  ),
                                  Text(
                                    "Đang tải thông báo",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Column(
                            children: center.list
                                .map((item) => NotificationCard(item))
                                .toList(),
                          ),
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
