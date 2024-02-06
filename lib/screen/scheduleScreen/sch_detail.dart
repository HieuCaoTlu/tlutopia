import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tlutopia/object/Book.dart';
import 'package:tlutopia/object/Calendar.dart';
import 'package:tlutopia/object/Schedule.dart';
import 'package:tlutopia/object/User.dart';

class ScheduleDetail extends StatelessWidget {
  bool success;
  bool addedToCalendar = false;
  Schedule schedule;
  ScheduleDetail(this.schedule, {this.success = false, super.key});

  @override
  Widget build(BuildContext context) {
    BookingCalendarProvider bookingCalendarProvider =
        BookingCalendarProvider.ofNonNull(context);
    final userProvider = UserProvider.of(context);
    if (userProvider == null) {
      // Xử lý khi không tìm thấy UserProvider
      return const Scaffold(
        body: Center(
          child: Text("error user providing"),
        ),
      );
    }
    if (success && !addedToCalendar) {
      // bookingCalendarProvider.addSchedule(schedule);
      schedule.fetchDataForEachBook(userProvider.user_id);
      addedToCalendar = true;
      bookingCalendarProvider.changed = true;
      bookingCalendarProvider.getAll(userProvider.user_id);
    }
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomLeft,
                  filterQuality: FilterQuality.high,
                  image: AssetImage('assets/images/bg3.png'),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    success ? "Thành công!" : "Lịch hẹn",
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xff5FA0FF)),
                    child: Text(
                      "Số lượng: ${schedule.listBooking.length}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: schedule.listBooking.length,
                  itemBuilder: (context, index) {
                    return MemoDetailBook(schedule.listBooking[index]);
                  },
                ),
                const Divider(
                  height: 20,
                  color: Colors.transparent,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(40, 20, 40, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ngày nhận',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          Text(DateFormat('d MMM', 'vi_VN')
                              .format(schedule.startTime)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xff5FA0FF)),
                        child: Text(
                          DateFormat('EEEE', 'vi_VN')
                              .format(schedule.startTime),
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(40, 20, 40, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ngày trả',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          Text(
                              'Thời hạn: ${differFromDate(schedule.startTime, schedule.endTime)}'),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xffECECEC)),
                        child: Text(
                          DateFormat('d/M', 'vi_VN').format(schedule.endTime),
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(40, 20, 50, 10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nơi nhận & trả',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Tầng 3',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(60, 40, 60, 0),
                  child: Center(
                    child: Column(
                      children: [
                        const Text(
                          "Nếu bạn không trả sách đúng hẹn, MSV sẽ bị đánh dấu “cảnh báo” và bị xử lí theo đúng quy định của nhà trường.",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 13, color: Color(0xff979797)),
                        ),
                        const Divider(
                          height: 20,
                          color: Colors.transparent,
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            if (success) {
                              success = false;
                              int numberOfPops =
                                  2; // Số lần pop bạn muốn thực hiện
                              Navigator.of(context).popUntil((route) {
                                // Kiểm tra số lần pop
                                numberOfPops--;
                                return numberOfPops < 0;
                              });
                            } else {
                              Navigator.of(context).pop();
                            }
                          },
                          shape: const CircleBorder(),
                          elevation: 0.0,
                          backgroundColor: Colors.grey.shade200, // Màu xám nhẹ
                          child:
                              const Icon(Icons.arrow_back, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ]),
    ));
  }
  // Thêm các thông tin khác cần hiển thị
}

String differFromDate(DateTime start, DateTime end) {
  Duration difference = end.difference(start);
  int days = difference.inDays;

  return '$days ngày';
}

class MemoDetailBook extends StatefulWidget {
  final Book book;
  const MemoDetailBook(this.book, {super.key});

  @override
  State<MemoDetailBook> createState() => _MemoDetailBookState();
}

class _MemoDetailBookState extends State<MemoDetailBook> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.fromLTRB(40, 20, 40, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.book.title,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          Text(
            widget.book.author,
            maxLines: 2,
            overflow: TextOverflow.fade,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
