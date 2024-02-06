import 'package:flutter/material.dart';
import 'package:tlutopia/object/Book.dart';
import 'package:tlutopia/object/Calendar.dart';
import 'package:tlutopia/object/Cart.dart';
import 'package:tlutopia/object/User.dart';
import 'package:tlutopia/screen/libScreen/cart_fragment.dart';

class DetailBook extends StatefulWidget {
  final Book item;
  final Cart cart;
  const DetailBook({required this.cart, required this.item, super.key});

  @override
  State<DetailBook> createState() => _DetailBookState();
}

class _DetailBookState extends State<DetailBook> {
  @override
  Widget build(BuildContext context) {
    BookingCalendarProvider provider =
        BookingCalendarProvider.ofNonNull(context);
    UserProvider userProvider = UserProvider.ofNonNull(context);
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
              backgroundColor: Colors.grey.shade200, // Màu xám nhẹ
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: NetworkImage(widget.item.cover),
                      fit: BoxFit.fill,
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
                    showDescription(widget.item,
                        context); // Hiển thị Snackbar khi nhấn vào mô tả
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
                    textAlign: TextAlign.justify, // Đổi text nút nếu cần thiết
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
                      if (widget.cart.isBookInCart(widget.item) ||
                          provider.isBookIdExist(widget.item)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Không được thêm: ${widget.item.title}'),
                            duration: const Duration(
                                seconds: 1), // Thời gian hiển thị Snackbar
                          ),
                        );
                      } else if (widget.item.quantity > 0) {
                        widget.cart.addToCart(widget.item);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Đã thêm vào giỏ: ${widget.item.title}'),
                            duration: const Duration(
                                seconds: 1), // Thời gian hiển thị Snackbar
                          ),
                        );
                      } else {
                        // _showSnackbar('Hết hàng');
                      }
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
                      if (provider.isBookIdExist(widget.item)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Không được thêm: ${widget.item.title}'),
                            duration: const Duration(
                                seconds: 1), // Thời gian hiển thị Snackbar
                          ),
                        );
                      } else if (widget.item.quantity > 0) {
                        if (!widget.cart.isBookInCart(widget.item)) {
                          widget.cart.addToCart(widget.item);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CartFragment(true, widget.cart)),
                        );
                      } else {
                        // _showSnackbar('Hết hàng');
                      }
                      widget.cart.addToCart(widget.item);
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
                        fontSize: 15,
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
