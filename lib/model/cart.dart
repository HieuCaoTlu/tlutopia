// ignore_for_file: non_constant_identifier_names, must_be_immutable
import 'package:flutter/material.dart';
import 'package:tlutopia/model/book.dart';
import 'package:tlutopia/model/schedule.dart';

class Cart extends InheritedWidget {
  List<Book> list = [];
  List<Book> prohibited = [];

  Cart({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  void add(Book book) {
    if (isContain(book)) return;
    list.add(book);
  }

  void resetLoan() {
    list.clear();
  }

  bool isContain(Book other) {
    for (var book in list) {
      if (book.book_id == other.book_id) return true;
    }
    for (var book in prohibited) {
      if (book.book_id == other.book_id) return true;
    }
    return false;
  }

  bool isContainProhibited(Book other) {
    for (var book in prohibited) {
      if (book.book_id == other.book_id) return true;
    }
    return false;
  }

  void getProhibitedBooks(Schedule schedules) {
    for (var loan in schedules.list) {
      for (var other in loan.list) {
        if (!isContainProhibited(other)) prohibited.add(other);
      }
    }
  }

  void confirmCart() {
    for (var other in list) {
      if (!isContainProhibited(other)) prohibited.add(other);
    }
  }

  static Cart? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Cart>();
  }

  @override
  bool updateShouldNotify(Cart oldWidget) {
    return true;
  }

  static Cart ofNonNull(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<Cart>();
    assert(provider != null, 'Không tìm thấy đối tượng');
    return provider!;
  }
}
