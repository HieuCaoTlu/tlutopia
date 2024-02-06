import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tlutopia/object/Book.dart';
import 'package:tlutopia/object/Schedule.dart';
import 'package:http/http.dart' as http;

class BookingCalendarProvider extends InheritedWidget {
  List<Schedule> list;
  bool changed = true;

  bool isBookIdExist(Book other) {
    return list.any((schedule) => schedule.isBookIdExist(other));
  }

  BookingCalendarProvider({
    required this.list,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  static BookingCalendarProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<BookingCalendarProvider>();
  }

  @override
  bool updateShouldNotify(BookingCalendarProvider oldWidget) {
    return list != oldWidget.list;
  }

  static BookingCalendarProvider ofNonNull(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<BookingCalendarProvider>();
    assert(provider != null, 'No BookingCalendarProvider found in context');
    return provider!;
  }

  void addSchedule(Schedule schedule) {
    list.add(schedule);
  }

  Future<void> getAll(int userId) async {
    if (!changed) return;
    var url =
        Uri.parse('http://tlu-booklending.mooo.com/api/loans?user_id=$userId');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> loanList = json.decode(response.body);
        List<Schedule> schedules = [];

        if (loanList.isEmpty) return;

        Map<String, List<Map<String, dynamic>>> groupedLoans = {};

        for (var loan in loanList) {
          String loanDate = loan['loan_date'];
          print(loan);
          if (!groupedLoans.containsKey(loanDate)) {
            groupedLoans[loanDate] = [];
          }
          groupedLoans[loanDate]!.add(loan);
        }

        groupedLoans.forEach((loanDate, loans) {
          List<Book> listBooking = [];
          String status = '';
          DateTime startTime = DateTime.parse(loans[0]['loan_date']);
          DateTime endTime = DateTime.parse(loans[0]['due_date']);

          for (var loan in loans) {
            Book book = Book(0, '', '', '', '', '', 0, '');
            book.getBook(loan['book_id']);
            listBooking.add(book);
          }

          Schedule schedule = Schedule.withParameters(
            startTime: startTime,
            endTime: endTime,
            status: status,
            listBooking: listBooking,
          );
          schedules.add(schedule);
        });

        list = schedules;
        changed = false;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
