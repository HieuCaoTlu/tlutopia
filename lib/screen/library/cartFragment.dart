// ignore_for_file: file_names, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tlutopia/model/book.dart';
import 'package:tlutopia/model/cart.dart';
import 'package:tlutopia/model/loan.dart';
import 'package:tlutopia/model/picker.dart';
import 'package:tlutopia/model/schedule.dart';
import 'package:tlutopia/model/user.dart';
import 'package:tlutopia/screen/library/bookDetail.dart';
import 'package:tlutopia/screen/schedule/loanDetail.dart';

class CartFragment extends StatefulWidget {
  const CartFragment({Key? key}) : super(key: key);

  @override
  State<CartFragment> createState() => _CartFragmentState();
}

class _CartFragmentState extends State<CartFragment> {
  DateTime start = DateTime.now();
  DateTime end = DateTime.now().add(const Duration(days: 14));
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Cart cart = Cart.ofNonNull(context);
    return Scaffold(
      body: isLoading
          ? Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Color(0xff3184FF),
                    ),
                    Divider(
                      height: 10,
                      color: Colors.transparent,
                    ),
                    Text(
                      "Đang tạo lịch hẹn, vui lòng đợi trong giây lát",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.07,
                  MediaQuery.of(context).size.height * 0.07,
                  MediaQuery.of(context).size.width * 0.07,
                  0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FloatingActionButton(
                      heroTag: 'no',
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
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w700),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xff5FA0FF)),
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Số lượng: ${cart.list.length}",
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                    Visibility(
                      visible: cart.list.isNotEmpty,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            height: 170,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: cart.list.length,
                              separatorBuilder: (context, _) => const SizedBox(
                                width: 20,
                              ),
                              itemBuilder: (context, index) => appearList(
                                  cart, cart.list.reversed.toList()[index]),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        // setState(() {
                                        //   start = newDate;
                                        // });
                                      },
                                    )
                                  ],
                                ),
                                const Divider(
                                  height: 20,
                                  color: Colors.transparent,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        // setState(() {
                                        //   end = newDate;
                                        // });
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Nơi nhận & trả',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        'Tầng 3',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
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
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: const Text(
                                        "Ấn xác nhận là bạn đã đồng ý với quy định mượn và trả sách của nhà trường.",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
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
                                              context, start, end, cart);
                                        },
                                        style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
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
            ),
    );
  }

  Widget appearList(Cart cart, Book item) => GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailBook(
                      item: item,
                    ))),
        child: Container(
          alignment: Alignment.topLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.18,
                width: MediaQuery.of(context).size.width * 0.25,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: NetworkImage(item.cover),
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
                          item.title,
                          maxLines: 3,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
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
                          fontSize: 10,
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
                              shadowColor:
                                  MaterialStatePropertyAll(Colors.transparent),
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xffECECEC))),
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
      );

  void deleteItem(Cart cart, Book item) {
    setState(() {
      cart.list.remove(item);
    });
  }

  Future<void> checkingCart(
      BuildContext context, DateTime start, DateTime end, Cart cart) async {
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
    if (rentalDays < 1 || rentalDays > 14) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Thời gian mượn chỉ giới hạn trong 14 ngày'),
        ),
      );
      return;
    }

    // Trả về một đối tượng nếu các điều kiện đều đúng
    Loan loan = Loan();
    loan.list.addAll(cart.list);
    loan.loan_date = start;
    loan.duration = 14;
    loan.due_date = loan.loan_date.add(Duration(days: loan.duration));
    loan.status = 'Bình thường';

    // Hiển thị thông báo thành công
    setState(() {
      cart.confirmCart();
      cart.resetLoan();
      isLoading = true;
    });

    //Loading
    Schedule schedule = Schedule.ofNonNull(context);
    User user = User.ofNonNull(context);
    try {
      await loan.createLoan(user.user_id);
      await schedule.update(user.user_id);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã xảy ra lỗi không mong muốn: $error'),
        ),
      );
      
      return;
    }

    setState(() {
      isLoading = false;
    });

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LoanDetail(
              loan,
              success: true,
            )));
  }
}
