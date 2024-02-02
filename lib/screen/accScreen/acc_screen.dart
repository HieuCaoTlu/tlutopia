import 'package:flutter/material.dart';
import 'package:tlutopia/screen/accScreen/apptheme.dart';

import 'information.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                alignment: Alignment.bottomLeft,
                image: AssetImage('assets/images/bg1.png'),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                "Cá nhân",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
            ]),
          ),
          const Column(children: [Information(), AppTheme()]),
          const Padding(
            padding: EdgeInsets.fromLTRB(40, 40, 40, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Cài đặt",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Chưa có bản cập nhật mới",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Divider(
                  height: 20,
                  color: Colors.transparent,
                ),
                NotificationCard(),
                Divider(
                  height: 20,
                  color: Colors.transparent,
                ),
                EnabledDarkMode(),
                Divider(
                  height: 20,
                  color: Colors.transparent,
                ),
                QuestionPool(),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title = 'Thông báo: đang bật';
  // final String detail;
  final String source = 'Bấm để tắt thông báo';
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: const Color(0xffECECEC),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    source,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class EnabledDarkMode extends StatelessWidget {
  final String title = 'Nền tối: tự động';
  // final String detail;
  final String source = 'Bấm để tắt';
  const EnabledDarkMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: const Color(0xffECECEC),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    source,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class QuestionPool extends StatelessWidget {
  final String title = 'Câu hỏi thường gặp';
  // final String detail;
  final String source = 'Bấm để xem chi tiết';
  const QuestionPool({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: const Color(0xffECECEC),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    source,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
