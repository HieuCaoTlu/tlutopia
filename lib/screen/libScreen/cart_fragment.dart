import 'package:flutter/material.dart';
import 'package:tlutopia/object/Book.dart';
import 'package:tlutopia/object/Cart.dart';
import 'package:tlutopia/screen/libScreen/detail_book.dart';

class CartFragment extends StatefulWidget {
  final Cart cart;

  const CartFragment(this.cart, {Key? key}) : super(key: key);

  @override
  State<CartFragment> createState() => _CartFragmentState();
}

class _CartFragmentState extends State<CartFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.07,
            MediaQuery.of(context).size.height * 0.07, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              shape: const CircleBorder(),
              elevation: 0.0,
              backgroundColor: Colors.grey.shade200, // Màu xám nhẹ
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
            Visibility(
              visible: widget.cart.size > 0,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    height: 300,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.cart.size,
                      separatorBuilder: (context, _) => const SizedBox(
                        width: 20,
                      ),
                      itemBuilder: (context, index) =>
                          appearList(widget.cart, widget.cart.items[index]),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        shadowColor:
                            MaterialStatePropertyAll(Colors.transparent),
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xffECECEC)),
                      ),
                      onPressed: clearCart,
                      child: const Text(
                        'Xóa tất cả',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget appearList(Cart cart, Book item) => Container(
        width: 130,
        height: 300,
        color: const Color(0xffECECEC),
        child: Material(
          child: InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DetailBook(cart: widget.cart, item: item))),
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

  void clearCart() {
    setState(() {
      widget.cart.items.clear();
      widget.cart.size = 0;
    });
  }
}
