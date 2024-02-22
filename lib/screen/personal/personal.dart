import 'package:flutter/material.dart';
import 'package:tlutopia/model/cart.dart';
import 'package:tlutopia/model/schedule.dart';
import 'package:tlutopia/screen/login/login.dart';
import 'package:tlutopia/screen/personal/askConfig.dart';
import 'package:tlutopia/screen/personal/changeButton.dart';

import 'infoConfig.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => PersonalScreenState();
}

class PersonalScreenState extends State<PersonalScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
        top: false,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Image(
                      image: AssetImage('assets/images/bg1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.07),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Cá nhân",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w700),
                        ),
                        Divider(
                          height: MediaQuery.of(context).size.height * 0.01,
                          color: Colors.transparent,
                        ),
                        const InformationConfiguring(),
                        Divider(
                          height: MediaQuery.of(context).size.height * 0.03,
                          color: Colors.transparent,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                "Cài đặt",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                "Đang cập nhật cài đặt mới",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: MediaQuery.of(context).size.height * 0.03,
                          color: Colors.transparent,
                        ),
                        const AskingConfiguration(),
                        Divider(
                          height: MediaQuery.of(context).size.height * 0.05,
                          color: Colors.transparent,
                        ),

                        Divider(
                          height: MediaQuery.of(context).size.height * 0.05,
                          color: Colors.transparent,
                        ),
                        const LogoutScreen()
                      ],
                    ),
                  )
                ]),
          ),
        ));
  }
}

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Color(0xffECECEC)),
          maximumSize: MaterialStatePropertyAll(Size(300, 500)),
          shadowColor: MaterialStatePropertyAll(Colors.transparent),
        ),
        onPressed: () {
          logout(context);
        },
        child: const Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'Đăng xuất',
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  void logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Xác nhận",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          content: const Text(
            "Bạn có chắc chắn muốn đăng xuất không?",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          backgroundColor: Colors.white,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Không",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                Schedule schedule = Schedule.ofNonNull(context);
                Cart cart = Cart.ofNonNull(context);
                schedule.list.clear();
                cart.list.clear();
                cart.prohibited.clear();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const LoginScreen()), // hoặc MainScreen()
                  (route) => false,
                );
              },
              child: const Text("Có",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
            ),
          ],
        );
      },
    );
  }
}
