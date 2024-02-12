// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tlutopia/model/book.dart';
import 'package:tlutopia/screen/library/bookDetail.dart';

class SearchFragment extends StatefulWidget {
  final List<Book> list;
  final List<String> majors;
  const SearchFragment({required this.list, required this.majors, Key? key})
      : super(key: key);

  @override
  State<SearchFragment> createState() => _SearchFragmentState();
}

class _SearchFragmentState extends State<SearchFragment> {
  final FocusNode focus = FocusNode();
  bool searching = false;
  String searchKeyword = '';
  String selectedMajor = '';

  List<Book> searchBooks(String keyword) {
    return widget.list
        .where((book) =>
            (book.title.toLowerCase().contains(keyword.toLowerCase()) ||
                book.author.toLowerCase().contains(keyword.toLowerCase())) &&
            (selectedMajor.isEmpty || book.major == selectedMajor))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    focus.requestFocus();
  }

  @override
  void dispose() {
    focus.dispose();
    super.dispose();
  }

  Future<void> filterMajor(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Lọc theo ngành: '),
          content: SingleChildScrollView(
            child: ListBody(
              children: widget.majors
                  .map((major) => ListTile(
                        title: Text(major),
                        onTap: () {
                          setState(() {
                            selectedMajor = major;
                            searching = true;
                          });
                          Navigator.of(context).pop();
                        },
                      ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  void clearFilter() {
    setState(() {
      selectedMajor = '';
      searching = true;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    left: MediaQuery.of(context).size.width * 0.09,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      shape: const CircleBorder(),
                      elevation: 0.0,
                      backgroundColor: Colors.grey.shade200, // Màu xám nhẹ
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
                    left: MediaQuery.of(context).size.width * 0.1, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.1,
                          top: 10,
                          bottom: 10),
                      decoration: BoxDecoration(
                          color: const Color(0xffECECEC),
                          borderRadius: BorderRadius.circular(25)),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        focusNode: focus,
                        onChanged: (value) {
                          setState(() {
                            searchKeyword = value;
                            searching = true;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: "Tìm kiếm đầu sách",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          fillColor: Color(0xffEFEFEF),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        filterMajor(context);
                      },
                      child:
                          const Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(
                          Icons.sort_rounded,
                          color: Colors.black,
                          size: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Lọc theo ngành",
                          style: TextStyle(fontSize: 17, color: Colors.black),
                        )
                      ]),
                    ),
                  ],
                ),
              ),
              searching
                  ? Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1,
                          top: 10,
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: searchBooks(searchKeyword).length,
                          separatorBuilder: (context, _) => const SizedBox(
                            width: 20,
                          ),
                          itemBuilder: (context, index) =>
                              buildCard(searchBooks(searchKeyword)[index]),
                        ),
                      ),
                    )
                  : Expanded(child: Container())
            ],
          ),
          floatingActionButton: selectedMajor.isNotEmpty
              ? FloatingActionButton(
                  heroTag: 'filter',
                  onPressed: clearFilter,
                  elevation: 0.0,
                  backgroundColor: Colors.grey.shade200,
                  child: const Icon(Icons.clear),
                )
              : null,
        ));
  }

  Widget buildCard(Book book) {
    return SizedBox(
      width: 130,
      child: GestureDetector(
        onTap: () {
          focus.unfocus();
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => DetailBook(item: book)));
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'book_${book.book_id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: NetworkImage(book.cover),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(
                      height: 10,
                      color: Colors.transparent,
                    ),
                    Text(
                      book.title,
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
                      book.author,
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
    );
  }
}
