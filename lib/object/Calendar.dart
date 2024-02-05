import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tlutopia/object/Book.dart';
import 'package:tlutopia/object/Schedule.dart';
import 'package:http/http.dart' as http;

class BookingCalendarProvider extends InheritedWidget {
  List<Schedule> list;

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
    var url =
        Uri.parse('http://tlu-booklending.mooo.com/api/loans?user_id=$userId');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> loanList = json.decode(response.body);
        List<Schedule> schedules = [];
        if (loanList.isEmpty) return;
        for (var loan in loanList) {
          DateTime startTime = DateTime.parse(loan['loan_date']);
          DateTime endTime = DateTime.parse(loan['due_date']);
          String status = loan['status'];
          List<Book> listBooking = await getBooksByLoanId(loan['id']);
          Schedule schedule = Schedule.withParameters(
            startTime: startTime,
            endTime: endTime,
            status: status,
            listBooking: listBooking,
          );
          schedules.add(schedule);
        }
        list = schedules;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<List<Book>> getBooksByLoanId(int loanId) async {
    var url = Uri.parse('http://tlu-booklending.mooo.com/api/loans/$loanId');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> loanData = json.decode(response.body);

        if (loanData.containsKey('book_id') && loanData['book_id'] is int) {
          Book newBook = Book(
            loanData['id'] ?? 0,
            loanData['title'] ?? '',
            loanData['author'] ?? '',
            loanData['description'] ?? '',
            loanData['publish_date'] ?? '',
            loanData['major'] ?? '',
            loanData['quantity'] ?? 0,
            loanData['cover'] ?? '',
          );
          return [newBook];
        } else {
          throw Exception('Invalid or missing book data');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
