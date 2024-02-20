// ignore_for_file: file_names, must_be_immutable
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tlutopia/model/book.dart';
import 'package:tlutopia/model/loan.dart';

class LoanDetail extends StatelessWidget {
  bool success;
  bool addedToSchedule = false;
  Loan loan;
  LoanDetail(this.loan, {this.success = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
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
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.095,
                  left: MediaQuery.of(context).size.width * 0.08,
                  child: FloatingActionButton(
                    heroTag: 'nothing',
                    onPressed: () {
                      if (success) {
                        success = false;
                        Navigator.of(context)
                            .popUntil(ModalRoute.withName("/library"));
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    shape: const CircleBorder(),
                    elevation: 0.0,
                    backgroundColor: Colors.grey.shade200, // Màu xám nhẹ
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
              ],
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
                      "Số lượng: ${loan.list.length}",
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
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: loan.list.length,
                  itemBuilder: (context, index) {
                    return MemoDetailBook(loan.list[index]);
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
                          Text(DateFormat('EEEE', 'vi_VN')
                              .format(loan.loan_date)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xff5FA0FF)),
                        child: Text(
                          DateFormat('d MMM', 'vi_VN').format(loan.loan_date),
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
                              'Thời hạn: ${differFromDate(loan.loan_date, loan.due_date)}'),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xffECECEC)),
                        child: Text(
                          DateFormat('d/M', 'vi_VN').format(loan.due_date),
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
                  child: const Center(
                    child: Column(
                      children: [
                        Text(
                          "Nếu bạn không trả sách đúng hẹn, MSV sẽ bị đánh dấu “cảnh báo” và bị xử lí theo đúng quy định của nhà trường.",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 13, color: Color(0xff979797)),
                        ),
                        Divider(
                          height: 20,
                          color: Colors.transparent,
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
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          Text(
            widget.book.author,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
