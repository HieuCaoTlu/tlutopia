import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tlutopia/object/Calendar.dart';
import 'package:tlutopia/object/Schedule.dart';
import 'package:tlutopia/object/User.dart';
import 'package:tlutopia/screen/scheduleScreen/sch_detail.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    BookingCalendarProvider provider =
        BookingCalendarProvider.ofNonNull(context);
    UserProvider userProvider = UserProvider.ofNonNull(context);
    provider.getAll(userProvider.user_id);
    // setState(() {
      
    // });
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
              "Lịch trình",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: ListView.builder(
            shrinkWrap: true, // Ensures ListView takes only required space
            physics:
                const NeverScrollableScrollPhysics(), // Disables scrolling within ListView
            itemCount: provider.list.length,
            itemBuilder: (context, index) {
              return ScheduleCard(provider.list[index]);
            },
          ),
        ),
      ]),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final Schedule schedule;
  const ScheduleCard(this.schedule, {super.key});

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
                          'Số lượng: ${schedule.listBooking.length.toString()}',
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
      ),
    );
  }
}
