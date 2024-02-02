import 'package:flutter/material.dart';

class NotifyScreen extends StatefulWidget {
  const NotifyScreen({super.key});

  @override
  State<NotifyScreen> createState() => _NotifyScreenState();
}

class _NotifyScreenState extends State<NotifyScreen> {
  final List<String> entries = <String>['Thông báo thư viện', 'Thông báo chủ nhiệm', 'Thông báo nào đó'];
  final List<String> colorCodes = <String>['demo', 'demo1', 'demo2'];
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
              "Thông báo",
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
              return NotificationCard(
                  entries[index], colorCodes[index].toString());
            },
          ),
        ),
      ]),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  // final String detail;
  final String source;
  final IconData icon = Icons.new_releases_rounded;
  const NotificationCard(this.title, this.source, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffECECEC),
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 5),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          children: [
            Icon(
              icon,
              size: 45,
              color: const Color(0xff3788FF),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  source,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
