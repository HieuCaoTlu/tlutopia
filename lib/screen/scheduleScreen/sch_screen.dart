import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final List<String> entries = <String>[
    'Lịch trình 1',
    'Lịch trình 2',
  ];
  final List<String> colorCodes = <String>['demo', 'demo1'];
  @override
  Widget build(BuildContext context) {
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
            itemCount: entries.length,
            itemBuilder: (context, index) {
              return ScheduleCard(entries[index], colorCodes[index].toString());
            },
          ),
        ),
      ]),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final String title;
  // final String detail;
  final String source;
  const ScheduleCard(this.title, this.source, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const Text(
                      "Số lượng: 2",
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 50,),
                Text(
                  "Tới nhận sách vào",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                ),
                Text(
                  "Thứ Năm - 21.12",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
