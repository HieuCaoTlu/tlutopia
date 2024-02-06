import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tlutopia/object/Book.dart';
import 'package:tlutopia/object/Cart.dart';
import 'package:tlutopia/object/User.dart';
import 'detail_book.dart';
import 'dart:math';

class LibraryFragment extends StatefulWidget {
  final Cart cart;
  const LibraryFragment(this.cart, {super.key});

  @override
  State<LibraryFragment> createState() => _LibraryFragmentState();
}

class _LibraryFragmentState extends State<LibraryFragment> {
  List<Book> data = [];
  List<Book> dataRandom = [];
  List<Book> dataNewest = [];
  String? major;

  @override
  void initState() {
    super.initState();
    data = [];
    dataRandom = [];
    dataNewest = [];
    fetchData();
    fetchDataNewest();
  }

  Future<void> fetchData() async {
    // Gửi yêu cầu GET đến server
    var url = Uri.parse('http://tlu-booklending.mooo.com/api/books');
    var response = await http.get(url);

    // Kiểm tra xem yêu cầu có thành công không (status code 200)
    if (response.statusCode == 200) {
      // Chuyển đổi dữ liệu JSON thành danh sách đối tượng
      final List<dynamic> jsonData = json.decode(response.body);
      for (var jsonBook in jsonData) {
        Book book = Book(
          jsonBook['id'],
          jsonBook['title'],
          jsonBook['author'],
          jsonBook['major'],
          jsonBook['description'],
          jsonBook['publish_date'],
          jsonBook['quantity'],
          jsonBook['cover'],
        );
        print('http://tlu-booklending.mooo.com/api/books/${jsonBook['id']}');
        if (jsonBook == jsonData.last) major = jsonBook['major'];
        setState(() {
          data.add(book);
          major;
        });
      }
      fetchDataRandom();
    } else {
      // Xử lý lỗi nếu có
      print('Request failed with status: ${response.statusCode}');
    }
  }

  Future<void> fetchDataRandom() async {
    // Gửi yêu cầu GET đến server
    var url = Uri.parse(
        'http://tlu-booklending.mooo.com/api/books/random?major=$major');
    var response = await http.get(url);
    print(url);

    // Kiểm tra xem yêu cầu có thành công không (status code 200)
    if (response.statusCode == 200) {
      // Chuyển đổi dữ liệu JSON thành danh sách đối tượng
      final List<dynamic> jsonData = json.decode(response.body);
      for (var jsonBook in jsonData) {
        Book book = Book(
          jsonBook['id'],
          jsonBook['title'],
          jsonBook['author'],
          jsonBook['major'],
          jsonBook['description'],
          jsonBook['publish_date'],
          jsonBook['quantity'],
          jsonBook['cover'],
        );
        setState(() {
          dataRandom.add(book);
        });
      }
    } else {
      // Xử lý lỗi nếu có
      print('Request failed with status: ${response.statusCode}');
    }
  }

  Future<void> fetchDataNewest() async {
    // Gửi yêu cầu GET đến server
    var url = Uri.parse('http://tlu-booklending.mooo.com/api/books/newest');
    var response = await http.get(url);

    // Kiểm tra xem yêu cầu có thành công không (status code 200)
    if (response.statusCode == 200) {
      // Chuyển đổi dữ liệu JSON thành danh sách đối tượng
      final List<dynamic> jsonData = json.decode(response.body);
      for (var jsonBook in jsonData) {
        Book book = Book(
          jsonBook['id'],
          jsonBook['title'],
          jsonBook['author'],
          jsonBook['major'],
          jsonBook['description'],
          jsonBook['publish_date'],
          jsonBook['quantity'],
          jsonBook['cover'],
        );
        setState(() {
          dataNewest.add(book);
        });
      }
    } else {
      // Xử lý lỗi nếu có
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = UserProvider.ofNonNull(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        alignment: Alignment.bottomLeft,
                        image: AssetImage('assets/images/bg3.png'),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.07,
                    left: MediaQuery.of(context).size.width * 0.07,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      shape: const CircleBorder(),
                      elevation: 0.0,
                      backgroundColor: Colors.grey.shade200, // Màu xám nhẹ
                      child: const Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                ]),
                const Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hôm nay ",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                      Text("Bạn muốn đọc gì?",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff2C81FF))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index == 0) {
                  return BookContent(widget.cart, data, "Được yêu thích");
                } else if (index == 1) {
                  return BookContent(widget.cart, dataRandom, "Khám phá: $major");
                } else {
                  return BookContent(widget.cart, dataNewest, "Mới nhất");
                }
              },
              childCount: 3,
            ),
          ),
          // Add more SliverList widgets if needed
        ],
      ),
    );
  }
}

class BookContent extends StatefulWidget {
  final List<Book> collection;
  final String content;
  final Cart cart;
  const BookContent(
    this.cart,
    this.collection,
    this.content, {
    super.key,
  });

  @override
  State<BookContent> createState() => _BookContentState();
}

class _BookContentState extends State<BookContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: Text(
              widget.content,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(40, 10, 0, 0),
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: widget.collection.length,
            separatorBuilder: (context, _) => const SizedBox(
              width: 20,
            ),
            itemBuilder: (context, index) =>
                buildCard(widget.cart, widget.collection[index]),
          ),
        ),
      ],
    );
  }

  Widget buildCard(Cart cart, Book item) => Container(
        width: 130,
        height: 300,
        color: const Color(0xffECECEC),
        child: Material(
          child: InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailBook(cart: cart, item: item))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 3 / 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: NetworkImage(item.cover),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          maxLines: 1,
                          softWrap: false,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                        Text(
                          item.author,
                          maxLines: 1,
                          softWrap: false,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
