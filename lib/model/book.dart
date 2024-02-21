// ignore_for_file: non_constant_identifier_names, must_be_immutable

class Book {
  int book_id = 0;
  String title = '';
  String author = '';
  String description = '';
  String publish_date = '';
  String major = '';
  int quantity = 0;
  String cover = '';

  Book(this.book_id, this.title, this.author, this.major, this.description,
      this.publish_date, this.quantity, this.cover);
}
