import 'package:tlutopia/object/Book.dart';
import 'package:tlutopia/object/Schedule.dart';

class Cart {
  List<Book> items = [];
  int size = 0;
  Schedule schedule = Schedule();

  bool isBookInCart(Book other) {
    return items.any((book) => book.bookID == other.bookID);
  }

  void addToCart(Book book) {
    if (!isBookInCart(book)) {
      if (size > 5) return;
      items.add(book);
      size++;
    }
  }

  void resetCart() {
    items.clear();
    size = 0;
    schedule = Schedule();
  }

  Cart copy() {
    Cart copied = Cart();
    copied.items = List.from(items);
    copied.size = size;
    copied.schedule = Schedule.withParameters(
        startTime: schedule.startTime,
        endTime: schedule.endTime,
        status: schedule.status,
        listBooking: List.from(schedule.listBooking));
    return copied;
  }
}
