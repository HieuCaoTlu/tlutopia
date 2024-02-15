// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tlutopia/model/book.dart';

class Loan {
  List<Book> list = [];
  late DateTime loan_date;
  late int duration;
  late DateTime due_date;
  late String status;

  Loan();

  bool available(Book other) {
    return list.any((book) => book.book_id == other.book_id);
  }

  void add(Book book) {
    if (!available(book)) {
      if (list.length > 5) return;
      list.add(book);
    }
  }

  void resetLoan() {
    list.clear();
  }

  Loan copy() {
    Loan copied = Loan();
    copied.list = List.from(list);
    return copied;
  }

  Future<void> createLoan(int userId) async {
    var url = Uri.parse('http://tlu-booklending.cloudns.be/api/loans');

    for (final book in list) {
      var data = {
        'book_id': book.book_id.toString(),
        'user_id': userId.toString(),
      };

      var response = await http.post(url, body: data);
      final info = json.decode(response.body);
      if (info['id'] != null) {
        print('Loan created successfully for book ${book.book_id}');
      } else {
        print('Failed to create loan for book ${book.book_id}');
        throw Exception('Failed to create loan for book ${book.book_id}');
      }
    }
  }

  void getLoan() async {
    for (var book in list) {
      book.getBook();
    }
  }
}
