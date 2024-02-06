import 'dart:convert';

import 'package:http/http.dart' as http;

class Book {
  int id = 0;
  String title = '';
  String author = '';
  String description = '';
  String publish_date = '';
  String major = '';
  int quantity = 0;
  String cover = '';

  Book(this.id, this.title, this.author, this.major, this.description,
      this.publish_date, this.quantity, this.cover);

  Future<void> getBook(int book_id) async {
    var bookUrl =
        Uri.parse('http://tlu-booklending.mooo.com/api/books/$book_id');
    try {
      var bookResponse = await http.get(bookUrl);
      if (bookResponse.statusCode == 200) {
        // Xử lý dữ liệu sách ở đây
        final Map<String, dynamic> data = json.decode(bookResponse.body);
        id = data['id'] ?? 0;
        title = data['title'] ?? '';
        author = data['author'] ?? '';
        description = data['description'] ?? '';
        publish_date = data['publish_date'] ?? '';
        major = data['major'] ?? '';
        quantity = data['quantity'] ?? '';
        cover = data['cover'] ?? '';
      } else {
        print('Failed to fetch book data for book ID');
      }
    } catch (error) {
      print('Error fetching book data: $error');
    }
  }
}
