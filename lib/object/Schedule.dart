import 'package:tlutopia/object/Book.dart';
import 'package:http/http.dart' as http;

class Schedule {
  DateTime startTime;
  DateTime endTime;
  String status;
  List<Book> listBooking = [];

  Schedule()
      : startTime = DateTime.now(),
        endTime = DateTime.now().add(const Duration(days: 1)),
        status = '',
        listBooking = List<Book>.empty();

  Schedule.withParameters(
      {required this.startTime,
      required this.endTime,
      required this.status,
      required this.listBooking});

  void addToSchedule(Book book) {
    listBooking.add(book);
  }

  bool isBookIdExist(Book other) {
    return listBooking.any((book) => book.id == other.id);
  }

  void fetchDataForEachBook(int user_id) {
    for (Book book in listBooking) {
      fetchData(book.id, user_id);
      print(book.id);
    }
  }

  void fetchData(int book_id, int user_id) async {
    var url = Uri.parse(
        'http://tlu-booklending.mooo.com/api/loans?book_id=${book_id}&user_id=${user_id}');
    try {
      var response = await http.post(url);
      if (response.statusCode == 201) {
        print('Loan added successfully');
      } else {
        print('Error: Không thành công');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
