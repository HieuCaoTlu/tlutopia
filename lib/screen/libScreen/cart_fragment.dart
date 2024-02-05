import 'package:flutter/material.dart';
import 'package:tlutopia/object/Book.dart';
import 'package:tlutopia/object/Cart.dart';
import 'package:tlutopia/object/Schedule.dart';
import 'package:tlutopia/object/picker.dart';
import 'package:tlutopia/screen/libScreen/detail_book.dart';
import 'package:intl/intl.dart';
import 'package:tlutopia/screen/scheduleScreen/sch_detail.dart';

class CartFragment extends StatefulWidget {
  final Cart cart;
  final bool newPage;

  const CartFragment(this.newPage, this.cart, {Key? key}) : super(key: key);

  @override
  State<CartFragment> createState() => _CartFragmentState();
}

class _CartFragmentState extends State<CartFragment> {
  DateTime start = DateTime.now();
  DateTime end = DateTime.now().add(const Duration(days: 7));


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
            if (widget.newPage)
              FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                shape: const CircleBorder(),
                elevation: 0.0,
                backgroundColor: Colors.grey.shade200, // Màu xám nhẹ
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            const Divider(
              height: 15,
              color: Colors.transparent,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Giỏ sách",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xff5FA0FF)),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(right: 40),
                  child: Text(
                    "Số lượng: ${widget.cart.size}",
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
            Visibility(
              visible: widget.cart.size > 0,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    height: 170,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.cart.size,
                      separatorBuilder: (context, _) => const SizedBox(
                        width: 20,
                      ),
                      itemBuilder: (context, index) => appearList(widget.cart,
                          widget.cart.items.reversed.toList()[index]),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 40, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Ngày nhận',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(DateFormat('EEEE, d MMM', 'vi_VN')
                                    .format(start)),
                              ],
                            ),
                            SetTime(
                              select: start,
                              onDateChanged: (newDate) {
                                setState(() {
                                  start = newDate;
                                });
                              },
                            )
                          ],
                        ),
                        const Divider(
                          height: 20,
                          color: Colors.transparent,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Ngày trả',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(DateFormat('EEEE, d MMM', 'vi_VN')
                                    .format(end)),
                              ],
                            ),
                            SetTime(
                              select: end,
                              onDateChanged: (newDate) {
                                setState(() {
                                  end = newDate;
                                });
                              },
                            )
                          ],
                        ),
                        const Divider(
                          height: 20,
                          color: Colors.transparent,
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 25),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Nơi nhận & trả',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Tầng 3',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 25,
                          color: Colors.transparent,
                        ),
                        Center(
                          child: Column(children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: const Text(
                                "Ấn xác nhận là bạn đã đồng ý với quy định mượn và trả sách của nhà trường.",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              margin: const EdgeInsets.only(top: 35),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xffF64141),
                                    Color(0xffFF6666)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  checkingCart(
                                      context, start, end, widget.cart);
                                },
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.transparent),
                                  shadowColor: MaterialStatePropertyAll(
                                      Colors.transparent),
                                ),
                                child: const Text(
                                  'Xác nhận',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        )
                      ],
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
        color: const Color(0xffECECEC),
        child: Material(
          child: InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailBook(
                          cart: widget.cart,
                          item: item,
                        ))),
            child: Container(
              alignment: Alignment.topLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: const Color.fromARGB(255, 243, 243, 243),
                    height: MediaQuery.of(context).size.height * 0.18,
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        image: AssetImage(item.url),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    width: MediaQuery.of(context).size.width * 0.3,
                    margin: const EdgeInsets.only(right: 10),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              item.bookName,
                              maxLines: 3,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          Text(
                            item.author,
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.fade,
                          ),
                          const Divider(
                            height: 10,
                            color: Colors.transparent,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                deleteItem(cart, item);
                              },
                              style: const ButtonStyle(
                                  shadowColor: MaterialStatePropertyAll(
                                      Colors.transparent),
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color(0xffECECEC))),
                              child: const Text(
                                "Xóa",
                                style: TextStyle(color: Colors.black),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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

  void deleteItem(Cart cart, Book item) {
    setState(() {
      cart.items.remove(item);
      cart.size = cart.items.length;
    });
  }

  void checkingCart(
      BuildContext context, DateTime start, DateTime end, Cart cart) {
    // Kiểm tra end có lớn hơn start không
    if (end.isBefore(start)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('End date must be greater than start date'),
        ),
      );
      return;
    }

    // Kiểm tra start có nằm trong khoảng 1 tuần tính từ hôm nay không
    DateTime currentDate = DateTime.now();
    DateTime yesterday = currentDate.subtract(const Duration(days: 1));

    if (start.isBefore(yesterday)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ngày bắt đầu mượn chỉ tính từ hôm nay trở đi'),
        ),
      );
      return;
    }

    // Kiểm tra thời gian mượn có nằm trong khoảng từ 1 đến 10 ngày không
    int rentalDays = end.difference(start).inDays;
    if (rentalDays < 1 || rentalDays > 9) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Thời gian mượn chỉ giới hạn trong 10 ngày'),
        ),
      );
      return;
    }

    // Trả về một đối tượng Schedule nếu các điều kiện đều đúng
    Schedule schedule = Schedule.withParameters(
        startTime: start, endTime: end, status: '', listBooking: cart.items);
    cart.schedule = schedule;

    // Hiển thị thông báo thành công
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tạo thành công lịch hẹn'),
        duration: Duration(seconds: 1),
      ),
    );

    Cart cartCopy = cart.copy();
    Schedule newSch = cartCopy.schedule;
    cart.resetCart();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ScheduleDetail(newSch, success: true,)));
  }
}
