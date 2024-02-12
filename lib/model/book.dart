// ignore_for_file: non_constant_identifier_names, must_be_immutable
import 'dart:convert';
import 'package:http/http.dart' as http;

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

  Future<void> getBook() async {
    var url = Uri.parse('http://192.168.1.8/aserver/book.php?book_id=$book_id');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        book_id = int.parse(data['book_id']);
        title = data['title'] ?? '';
        author = data['author'] ?? '';
        description = data['description'] ?? '';
        publish_date = data['publish_date'] ?? '';
        major = data['major'] ?? '';
        quantity = int.parse(data['quantity']);
        cover = data['cover'] ?? '';
      } else {
        print('Failed to fetch book data for book ID');
      }
    } catch (error) {
      print('Error fetching book data: $error');
    }
  }
}
