import 'package:tlutopia/object/Book.dart';

class Schedule {
  DateTime startTime;
  DateTime endTime;
  String status;
  List<Book> listBooking = [];

  Schedule()
      : startTime = DateTime.now(),
        endTime = DateTime.now().add(const Duration(days: 1)),
        status = '',
        listBooking = List<Book>.empty();

  Schedule.withParameters(
      {required this.startTime,
      required this.endTime,
      required this.status,
      required this.listBooking});

  void addToSchedule(Book book) {
    listBooking.add(book);
  }
}
