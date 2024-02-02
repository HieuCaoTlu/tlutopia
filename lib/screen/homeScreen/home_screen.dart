import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String name = 'Hiếu';
  final bool schedule = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Xin chào, $name!",
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w700),
                ),
                const Divider(
                  height: 5,
                  color: Colors.transparent,
                ),
                const Text(
                  "Lịch hẹn gần đây",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                RecentSchedule(schedule),
                const Text(
                  "Tính năng",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Divider(
                  height: 20,
                  color: Colors.transparent,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Feature('assets/images/ft1.png'),
                    Feature('assets/images/ft2.png')
                  ],
                ),
                Divider(
                  height: MediaQuery.of(context).size.height * 0.02,
                  color: Colors.transparent,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Feature('assets/images/ft3.png'),
                    Feature('assets/images/ft4.png')
                  ],
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class RecentSchedule extends StatelessWidget {
  final bool schedule;
  const RecentSchedule(this.schedule, {super.key});

  @override
  Widget build(BuildContext context) {
    if (schedule) return const Placeholder();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xffECECEC),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Text(
              "Chưa có lịch hẹn",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}

class Feature extends StatelessWidget {
  final String link;
  const Feature(this.link, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Navigator.push(
          // context,
          // MaterialPageRoute(
          //   builder: (context) => Null()
          // ),
          // );
        },
        child: Image(
          image: AssetImage(link),
          height: MediaQuery.of(context).size.height * 0.18,
          width: MediaQuery.of(context).size.width * 0.38,
          fit: BoxFit.fill,
          filterQuality: FilterQuality.high,
        ));
  }
}