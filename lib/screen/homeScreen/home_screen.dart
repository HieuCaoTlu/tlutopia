import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tlutopia/object/Calendar.dart';
import 'package:tlutopia/object/Schedule.dart';
import 'package:tlutopia/object/User.dart';
import 'package:tlutopia/screen/libScreen/lib_screen.dart';
import 'package:tlutopia/screen/scheduleScreen/sch_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bool schedule = false;

  String getMainName(String name) {
    List<String> names = name.split(' ');
    if (names.isNotEmpty) {
      return names.last;
    } else {
      return ''; // hoặc giá trị mặc định khác tùy bạn
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = UserProvider.ofNonNull(context);
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      "Xin chào, ${getMainName(userProvider.studentName)}!",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Feature('assets/images/ft1.png', 0, userProvider),
                        Feature('assets/images/ft2.png', 1, userProvider)
                      ],
                    ),
                    Divider(
                      height: MediaQuery.of(context).size.height * 0.02,
                      color: Colors.transparent,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Feature('assets/images/ft3.png', 2, userProvider),
                        Feature('assets/images/ft4.png', 3, userProvider)
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
    final provider = BookingCalendarProvider.ofNonNull(context);
    final userProvider = UserProvider.ofNonNull(context);
    provider.getAll(userProvider.user_id);
    if (provider.list.isNotEmpty) {
      return CustomScrollView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          const SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.only(top: 20),
          )),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return MemoSchedule(provider.list[index]);
              },
              childCount: 1,
            ),
          ),
        ],
      );
    }
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
  final int number;
  final UserProvider userProvider;
  const Feature(this.link, this.number, this.userProvider, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          switch (number) {
            case 0:
              // Xử lý khi number là 0
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LibraryScreen(),
                ),
              );
              break;
            case 2:
              // Xử lý khi number là 2
              break;
            case 3:
              // Xử lý khi number là 3
              break;
            default:
            // Xử lý mặc định nếu number không trùng với bất kỳ case nào
          }
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

class MemoSchedule extends StatelessWidget {
  final Schedule schedule;
  const MemoSchedule(this.schedule, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScheduleDetail(schedule)));
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xffECECEC),
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mượn sách",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "Tới nhận sách vào",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    DateFormat('EEEE - dd.MM', 'vi_VN')
                        .format(schedule.startTime),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
