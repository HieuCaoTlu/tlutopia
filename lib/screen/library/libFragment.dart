// ignore_for_file: file_names
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tlutopia/model/book.dart';
import 'package:tlutopia/model/schedule.dart';
import 'package:tlutopia/model/user.dart';

import 'bookContent.dart';
import 'searchFragment.dart';

class LibraryFragment extends StatefulWidget {
  const LibraryFragment({super.key});

  @override
  State<LibraryFragment> createState() => _LibraryFragmentState();
}

class _LibraryFragmentState extends State<LibraryFragment>
    with AutomaticKeepAliveClientMixin {
  List<Book> data = [];
  List<Book> dataRandom = [];
  List<Book> dataNewest = [];
  String? major;
  bool isDataFetched = false;

  @override
  void initState() {
    super.initState();
    data = [];
    dataRandom = [];
    dataNewest = [];
    fetchData();
    fetchDataNewest();
  }

  @override
  bool get wantKeepAlive => true;

  List<String> getMajors(List<Book> list) {
    List<String> majors = [];
    for (var book in list) {
      if (majors.contains(book.major)) continue;
      majors.add(book.major);
    }
    return majors;
  }

  Future<void> fetchData() async {
    if (isDataFetched) return;
    isDataFetched = true;
    var url = Uri.parse('http://tlu-booklending.cloudns.be/api/books');
    var response = await http.get(url);
    if (response.statusCode == 200) {
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
        if (jsonBook == jsonData.last) major = jsonBook['major'];
        if (mounted) {
          setState(() {
            data.add(book);
            major;
          });
        }
      }
      fetchDataRandom();
    } else {
      // Xử lý lỗi nếu có
      print('Request failed with status: ${response.statusCode}');
    }
  }

  Future<void> fetchDataRandom() async {
    var url = Uri.parse(
        'http://tlu-booklending.cloudns.be/api/books/newest?major=$major');
    var response = await http.get(url);
    if (response.statusCode == 200) {
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
        if (mounted) {
          setState(() {
            dataRandom.add(book);
          });
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  Future<void> fetchDataNewest() async {
    var url = Uri.parse('http://tlu-booklending.cloudns.be/api/books/newest');
    var response = await http.get(url);
    if (response.statusCode == 200) {
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
        if (mounted) {
          setState(() {
            dataNewest.add(book);
          });
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final schedule = Schedule.ofNonNull(context);
    final user = User.ofNonNull(context);
    schedule.update(user.user_id);
    return SafeArea(
      top: false,
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.125,
                child: const Image(
                  image: AssetImage('assets/images/bg3.png'),
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.06,
                left: MediaQuery.of(context).size.width * 0.07,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/flow',
                      (route) => false,
                    );
                  },
                  shape: const CircleBorder(),
                  elevation: 0.0,
                  backgroundColor: Colors.grey.shade200,
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.07, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hôm nay ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
                const Text("Bạn muốn đọc gì?",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff2C81FF))),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SearchFragment(list: data, majors: getMajors(data)))),
                  child: Container(
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.07,
                        top: 10,
                        bottom: MediaQuery.of(context).size.width * 0.07),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: const Color(0xffECECEC),
                        borderRadius: BorderRadius.circular(25)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tìm kiếm đầu sách",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        Icon(
                          Icons.search_rounded,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.07,
                top: 10,
              ),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BookContent(data, "Được yêu thích"),
                    BookContent(dataRandom, "Khám phá: $major"),
                    BookContent(dataNewest, "Mới nhất"),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
