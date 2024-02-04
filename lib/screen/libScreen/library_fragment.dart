import 'package:flutter/material.dart';
import 'package:tlutopia/object/Book.dart';
import 'package:tlutopia/object/Cart.dart';
import 'detail_book.dart';

class LibraryFragment extends StatefulWidget {
  final Cart cart;
  const LibraryFragment(this.cart, {super.key});

  @override
  State<LibraryFragment> createState() => _LibraryFragmentState();
}

class _LibraryFragmentState extends State<LibraryFragment> {
  final List<Book> collection1 = [
    Book(
        "Sword Art Online",
        "Hieu",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "2000",
        'Công nghệ thông tin',
        3,
        'assets/images/bg.png'),
    Book("Sword Art Online", "Hieu", "Không có", "2000", 'Công nghệ thông tin',
        3, 'assets/images/bg4.png'),
    Book("Sword Art Online", "Hieu", "Không có", "2000", 'Công nghệ thông tin',
        3, 'assets/images/bg2.png'),
    Book("Sword Art Online", "Hieu", "Không có", "2000", 'Công nghệ thông tin',
        3, 'assets/images/bg3.png'),
    Book("Sword Art Online", "Hieu", "Không có", "2000", 'Công nghệ thông tin',
        3, 'assets/images/logo.png'),
  ];

  @override
  Widget build(BuildContext context) {
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
                    height: 150,
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
                        "Hôm nay",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                      Text("Bạn muốn đọc gì?",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff2C81FF)))
                    ],
                  ),
                )
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index == 0) {
                  return BookContent(
                      widget.cart, collection1, "Được yêu thích");
                } else if (index == 1) {
                  return BookContent(widget.cart, collection1, "Tiêu biểu");
                } else {
                  return BookContent(widget.cart, collection1, "Mới nhất");
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
                      image: AssetImage(item.url),
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
                          item.bookName,
                          maxLines: 1,
                          softWrap: false,
                          style: const TextStyle(
                            fontFamily: "Roboto",
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
                            fontFamily: "Roboto",
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
