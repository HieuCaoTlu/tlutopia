import 'package:tlutopia/object/Book.dart';

class Cart {
  List<Book> items = [];
  int size = 0;

  bool isBookInCart(Book book) {
    return items.contains(book);
  }

  void addToCart(Book book) {
    if (!isBookInCart(book)) {
      if (size > 5) return;
      items.add(book);
      size++;
    }
  }
}
