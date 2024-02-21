import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tlutopia/model/loan.dart';
import 'package:tlutopia/model/schedule.dart';
import 'package:tlutopia/screen/schedule/loanDetail.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Schedule schedule = Schedule.ofNonNull(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Lịch trình",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: schedule.list.length,
              itemBuilder: (context, index) {
                return LoanCard(schedule.list[index]);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(60, 40, 60, 0),
            child: const Center(
              child: Column(
                children: [
                  Text(
                    "Nếu bạn mượn trong cùng một thời hạn, lịch hẹn sẽ được gộp chung",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 81, 81, 81)),
                  ),
                  Divider(
                    height: 20,
                    color: Colors.transparent,
                  ),
                  Text(
                    "Sau khi đặt lịch và tới thư viện, hãy tới quầy thủ thư để nhận sách",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 81, 81, 81)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LoanCard extends StatelessWidget {
  final Loan loan;
  const LoanCard(this.loan, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoanDetail(loan)));
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xffECECEC),
            borderRadius: BorderRadius.circular(25.0),
          ),
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 5),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Mượn sách",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Số lượng: ${loan.list.length.toString()}',
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "Tới nhận sách vào",
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      DateFormat('EEEE - dd.MM', 'vi_VN')
                          .format(loan.loan_date),
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
