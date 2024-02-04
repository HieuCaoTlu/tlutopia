import 'package:tlutopia/object/Book.dart';

class Schedule {
  DateTime startTime;
  DateTime endTime;
  String status;
  List<Book> listBooking = [];

  Schedule(this.startTime, this.endTime, this.status);

  void addToSchedule(Book book) {
    listBooking.add(book);
  }
}

class BookingCalendar {
  List<Schedule> list = [];
  int size = 0;

  bool isScheduleInCalendar(Schedule schedule) {
    return list.contains(schedule);
  }

  void addToCalendar(Schedule schedule) {
    if (!isScheduleInCalendar(schedule)) {
      if (size > 5) return;
      list.add(schedule);
      size++;
    }
  }
}
