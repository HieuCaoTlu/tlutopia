// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tlutopia/model/book.dart';
import 'package:tlutopia/model/cart.dart';
import 'package:tlutopia/model/schedule.dart';
import 'package:tlutopia/screen/library/cartFragment.dart';

class DetailBook extends StatelessWidget {
  final Book item;
  const DetailBook({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    Cart cart = Cart.ofNonNull(context);
    return SafeArea(
        top: false,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.135,
                      child: const Image(
                        image: AssetImage('assets/images/bg2.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.06,
                      left: MediaQuery.of(context).size.width * 0.07,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.of(context).pop();
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
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.06,
                      right: MediaQuery.of(context).size.width * 0.07,
                      child: FloatingActionButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const CartFragment()));
                          },
                          shape: const CircleBorder(),
                          elevation: 0.0,
                          splashColor: Colors.white,
                          heroTag: "cart",
                          backgroundColor: Colors.grey.shade200,
                          child: const Icon(
                            Icons.shopping_bag_rounded,
                            color: Colors.black,
                            size: 25,
                          )),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.07,
                      right: MediaQuery.of(context).size.width * 0.07),
                  child: Column(children: [
                    const Divider(
                      height: 15,
                      color: Colors.transparent,
                    ),
                    const Divider(
                      height: 25,
                      color: Colors.transparent,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.27,
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: Hero(
                            tag: 'book_${item.book_id}',
                            child: AspectRatio(
                              aspectRatio: 3 / 5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image(
                                  image: NetworkImage(item.cover),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.07),
                          width: MediaQuery.of(context).size.width * 0.39,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 6,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                const Divider(
                                  height: 10,
                                  color: Colors.transparent,
                                ),
                                Text(item.author,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                                const Divider(
                                  height: 20,
                                  color: Colors.transparent,
                                ),
                                Text(
                                    "Xuất bản: ${item.publish_date} \nNgành: ${item.major}",
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 40),
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
                                if ((cart.list.length +
                                        cart.prohibited.length +
                                        1) >
                                    5) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Bạn chỉ được mượn cùng một lúc tối đa 5 quyển sách'),
                                      duration: Duration(milliseconds: 500),
                                    ),
                                  );
                                } else {
                                  if (cart.isContain(item)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Không được thêm: ${item.title}'),
                                        duration:
                                            const Duration(milliseconds: 500),
                                      ),
                                    );
                                  } else if (item.quantity > 0) {
                                    cart.add(item);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Đã thêm vào giỏ: ${item.title}'),
                                        duration:
                                            const Duration(milliseconds: 500),
                                      ),
                                    );
                                  } else {}
                                }
                              },
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.transparent),
                                shadowColor: MaterialStatePropertyAll(
                                    Colors.transparent),
                              ),
                              child: const Text(
                                'Thêm vào giỏ sách',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
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
                                if ((cart.list.length +
                                        cart.prohibited.length +
                                        1) >
                                    5) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Bạn chỉ được mượn cùng một lúc tối đa 5 quyển sách'),
                                      duration: Duration(milliseconds: 500),
                                    ),
                                  );
                                } else {
                                  if (cart.isContainProhibited(item)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Không được thêm: ${item.title}'),
                                        duration:
                                            const Duration(milliseconds: 500),
                                      ),
                                    );
                                  } else if (item.quantity > 0) {
                                    if (!cart.list.contains(item)) {
                                      cart.add(item);
                                    }
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CartFragment()));
                                  } else {}
                                  cart.add(item);
                                }
                              },
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.transparent),
                                shadowColor: MaterialStatePropertyAll(
                                    Colors.transparent),
                              ),
                              child: const Text(
                                'Đặt ngay',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      "Tóm tắt nội dung",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    const Divider(
                      height: 20,
                      color: Colors.transparent,
                    ),
                    Text(
                      textAlign: TextAlign.justify,
                      item.description,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ]),
                )
              ],
            ),
          ),
        ));
  }
}
