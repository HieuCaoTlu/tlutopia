import 'package:flutter/material.dart';
import 'package:tlutopia/model/user.dart';

class InformationConfiguring extends StatefulWidget {
  const InformationConfiguring({super.key});

  @override
  State<InformationConfiguring> createState() => _InformationConfiguringState();
}

class _InformationConfiguringState extends State<InformationConfiguring> {
  void showInformation(BuildContext context, User user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          user.student_name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "ID người dùng: ${user.user_id}",
                          style: const TextStyle(fontSize: 13),
                        )
                      ],
                    ),
                  ),
                  PieceCardInformation(
                      description: "Mã sinh viên: ", value: user.student_code),
                  PieceCardInformation(
                      description: "Số điện thoại: ", value: user.phone),
                  PieceCardInformation(
                      description: "Email: ", value: user.email),
                  PieceCardInformation(
                      description: "Trạng thái: ", value: user.status),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                        color: const Color(0xffECECEC),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Đổi mật khẩu",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Chưa khả dụng",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xffDAEBFF)),
                        maximumSize: MaterialStatePropertyAll(Size(300, 500)),
                        shadowColor:
                            MaterialStatePropertyAll(Colors.transparent),
                      ),
                      child: const Text(
                        'Xong',
                        style: TextStyle(
                          color: Color(0xff3184FF),
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 20,
                    color: Colors.transparent,
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final User user = User.ofNonNull(context);
    return GestureDetector(
      onTap: () => showInformation(context, user),
      child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xffECECEC),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.account_circle_rounded,
                    size: 50,
                    color: Color.fromARGB(255, 78, 78, 78),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          user.student_name,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Row(
                        children: [
                          Text("${user.student_code} | ${user.phone}")
                        ],
                      )
                    ],
                  )
                ],
              ),
              const Icon(
                Icons.edit_rounded,
                size: 30,
                color: Color.fromARGB(255, 78, 78, 78),
              )
            ],
          )),
    );
  }
}

class PieceCardInformation extends StatelessWidget {
  const PieceCardInformation(
      {super.key, required this.description, required this.value});

  final String description;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 245, 245, 245),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            description,
            // overflow: TextOverflow.clip,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              value,
              // overflow: TextOverflow.clip,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
