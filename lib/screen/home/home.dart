import 'package:flutter/material.dart';
import 'package:tlutopia/model/loan.dart';
import 'package:tlutopia/model/schedule.dart';
import 'package:tlutopia/model/user.dart';
import 'package:intl/intl.dart';
import 'package:tlutopia/screen/library/lib.dart';
import 'package:tlutopia/screen/schedule/loanDetail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String getFirstName(String name) {
    List<String> names = name.split(' ');
    if (names.isNotEmpty) {
      return names.last;
    } else {
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User user = User.ofNonNull(context);
    Size screenSize = MediaQuery.of(context).size;
    double imageSize = screenSize.width * 0.4;
    double spacing = screenSize.width * 0.05;
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
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.07),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Xin chào! ${getFirstName(user.student_name)}",
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w700),
                        ),
                        Divider(
                          height: MediaQuery.of(context).size.height * 0.01,
                          color: Colors.transparent,
                        ),
                        const Text(
                          "Lịch hẹn gần đây",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const RecentSchedule(),
                        const Text(
                          "Các chức năng chính:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        Divider(
                          height: MediaQuery.of(context).size.height * 0.02,
                          color: Colors.transparent,
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        'assets/images/ft1.png',
                                        width: imageSize,
                                        height: imageSize,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spacing),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          settings: const RouteSettings(
                                              name: "/library"),
                                          builder: (context) =>
                                              const LibraryScreen(),
                                        ),
                                      ).then((value) {
                                        setState(() {
                                          print("reloaded!");
                                        });
                                      });
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        'assets/images/ft2.png',
                                        width: imageSize,
                                        height: imageSize,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spacing),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        'assets/images/ft3.png',
                                        width: imageSize,
                                        height: imageSize,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spacing),
                                  GestureDetector(
                                    onTap: () {},
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        'assets/images/ft4.png',
                                        width: imageSize,
                                        height: imageSize,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
              ],
            ),
          ),
        ));
  }
}

class RecentSchedule extends StatefulWidget {
  const RecentSchedule({super.key});

  @override
  State<RecentSchedule> createState() => _RecentScheduleState();
}

class _RecentScheduleState extends State<RecentSchedule> {
  @override
  Widget build(BuildContext context) {
    setState(() {
    });
    final Schedule schedule = Schedule.ofNonNull(context);
    if (schedule.list.isNotEmpty) {
      return CustomScrollView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          const SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.only(top: 20),
          )),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return MemoLoan(schedule.list[index]);
              },
              childCount: (schedule.list.length < 3 ? schedule.list.length : 0),
            ),
          ),
        ],
      );
    } else {
      return Center(
        child: Container(
          margin: const EdgeInsets.all(30),
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
      );
    }
  }
}

class MemoLoan extends StatefulWidget {
  final Loan loan;
  const MemoLoan(this.loan, {super.key});

  @override
  State<MemoLoan> createState() => _MemoLoanState();
}

class _MemoLoanState extends State<MemoLoan> {
  @override
  Widget build(BuildContext context) {
    setState(() {
    });
    return Material(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoanDetail(widget.loan)));
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
                crossAxisAlignment: CrossAxisAlignment.center,
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
                        .format(widget.loan.loan_date),
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
