// ignore_for_file: non_constant_identifier_names, must_be_immutable
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tlutopia/model/book.dart';
import 'package:tlutopia/model/loan.dart';

class Schedule extends InheritedWidget {
  List<Loan> list = [];

  Schedule({
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  static Schedule? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Schedule>();
  }

  @override
  bool updateShouldNotify(Schedule oldWidget) {
    return list != oldWidget.list;
  }

  static Schedule ofNonNull(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<Schedule>();
    assert(provider != null, 'Không tìm thấy đối tượng');
    return provider!;
  }

  bool available(Book other) {
    return list.any((loan) => loan.available(other));
  }

  void add(Loan loan) {
    list.add(loan);
  }

  Future<void> update(int user_id) async {
    final url = Uri.parse(
        'http://tlu-booklending.cloudns.be/api/loans/?user_id=$user_id');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Loan> temp = [];
        for (var data in jsonData) {
          final loan = Loan();
          Book book = Book(data['book_id'], '', '', '', '', '', 0, '');
          await book.getBook();
          loan.list.add(book);
          loan.loan_date = DateTime.parse(data['loan_date']);
          loan.due_date = DateTime.parse(data['due_date']);
          temp.add(loan);
        }

        List<Loan> mergedLoans = [];
        for (var loan in temp) {
          bool added = false;
          for (var mergedLoan in mergedLoans) {
            if (loan.loan_date == mergedLoan.loan_date &&
                loan.due_date == mergedLoan.due_date) {
              mergedLoan.list.addAll(loan.list);
              added = true;
              break;
            }
          }
          if (!added) {
            mergedLoans.add(loan);
          }
        }

        list.clear();
        list.addAll(mergedLoans);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Failed to load data: $error');
    }
  }
}
