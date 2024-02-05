import 'package:flutter/material.dart';
import 'package:tlutopia/object/Schedule.dart';

class BookingCalendar extends InheritedWidget {
  final List<Schedule> list;

  const BookingCalendar({
    required this.list,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  static BookingCalendar? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BookingCalendar>();
  }

  @override
  bool updateShouldNotify(BookingCalendar oldWidget) {
    return list != oldWidget.list;
  }
}

class BookingCalendarProvider extends InheritedWidget {
  final List<Schedule> list;

  const BookingCalendarProvider({
    required this.list,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  static BookingCalendarProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BookingCalendarProvider>();
  }

  @override
  bool updateShouldNotify(BookingCalendarProvider oldWidget) {
    return list != oldWidget.list;
  }

  static BookingCalendarProvider ofNonNull(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<BookingCalendarProvider>();
    assert(provider != null, 'No BookingCalendarProvider found in context');
    return provider!;
  }

  void addSchedule(Schedule schedule) {
    list.add(schedule);
  }
}
