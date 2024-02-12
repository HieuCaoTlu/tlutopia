// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:tlutopia/model/book.dart';
import 'package:tlutopia/model/cart.dart';
import 'package:tlutopia/screen/library/cartFragment.dart';

class DetailBook extends StatefulWidget {
  final Book item;
  const DetailBook({required this.item, super.key});

  @override
  State<DetailBook> createState() => _DetailBookState();
}

class _DetailBookState extends State<DetailBook> {
  @override
  Widget build(BuildContext context) {
    Cart cart = Cart.ofNonNull(context);
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 150,
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
              backgroundColor: Colors.grey.shade200,
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
        ]),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: const Color.fromARGB(27, 124, 124, 124),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Hero(
                    tag: 'book_${widget.item.book_id}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        image: NetworkImage(widget.item.cover),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 20,
                  color: Colors.transparent,
                ),
                Text(
                  widget.item.title,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w700),
                ),
                const Divider(
                  height: 20,
                  color: Colors.transparent,
                ),
                Text(widget.item.author,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500)),
                const Divider(
                  height: 10,
                  color: Colors.transparent,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xffDAEBFF)),
                    maximumSize: MaterialStatePropertyAll(Size(300, 500)),
                    shadowColor: MaterialStatePropertyAll(Colors.transparent),
                  ),
                  child: Text(widget.item.major,
                      style: const TextStyle(
                        color: Color(0xff3184FF),
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      )),
                ),
                const Divider(
                  height: 20,
                  color: Colors.transparent,
                ),
                ElevatedButton(
                  onPressed: () {
                    showDescription(widget.item, context);
                  },
                  style: const ButtonStyle(
                    shadowColor: MaterialStatePropertyAll(Colors.transparent),
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                    overlayColor: MaterialStatePropertyAll(Colors.white),
                    foregroundColor:
                        MaterialStatePropertyAll(Colors.transparent),
                    surfaceTintColor: MaterialStatePropertyAll(Colors.white),
                  ),
                  child: Text(
                    widget.item.description,
                    maxLines: 4,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 141, 141, 141),
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                const Divider(
                  height: 20,
                  color: Colors.transparent,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff5499FF), Color(0xff1B77FF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      print(cart.isContain(widget.item));
                      if (cart.isContain(widget.item)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Không được thêm: ${widget.item.title}'),
                            duration: const Duration(milliseconds: 500),
                          ),
                        );
                      } else if (widget.item.quantity > 0) {
                        cart.add(widget.item);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Đã thêm vào giỏ: ${widget.item.title}'),
                            duration: const Duration(milliseconds: 500),
                          ),
                        );
                      } else {}
                    },
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.transparent),
                      shadowColor: MaterialStatePropertyAll(Colors.transparent),
                    ),
                    child: const Text(
                      'Thêm vào giỏ sách',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xffF64141), Color(0xffFF6666)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (cart.isContainProhibited(widget.item)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Không được thêm: ${widget.item.title}'),
                            duration: const Duration(milliseconds: 500),
                          ),
                        );
                      } else if (widget.item.quantity > 0) {
                        if (!cart.list.contains(widget.item)) {
                          cart.add(widget.item);
                        }
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const CartFragment()));
                      } else {}
                      cart.add(widget.item);
                    },
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.transparent),
                      shadowColor: MaterialStatePropertyAll(Colors.transparent),
                    ),
                    child: const Text(
                      'Đặt ngay',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }

  void showDescription(Book information, BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(
                    'Xuất bản: ${information.publish_date}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Container(
                    padding: EdgeInsets.fromLTRB(
                        0,
                        MediaQuery.of(context).size.height * 0.005,
                        0,
                        MediaQuery.of(context).size.height * 0.01),
                    child: Text(
                      'Số lượng còn lại: ${information.quantity.toString()}',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: ListTile(
                      title: Text(
                        textAlign: TextAlign.justify,
                        information.description,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
