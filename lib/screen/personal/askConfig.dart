import 'package:flutter/material.dart';

class AskingConfiguration extends StatefulWidget {
  const AskingConfiguration({super.key});

  @override
  State<AskingConfiguration> createState() => _AskingConfigurationState();
}

class _AskingConfigurationState extends State<AskingConfiguration> {
  void showInformation(BuildContext context) {
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
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text(
                      "Câu hỏi thường gặp",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                        color: const Color(0xffECECEC),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "TLUtopia là gì?",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        Divider(
                          height: 10,
                          color: Colors.transparent,
                        ),
                        Text(
                          "TLUtopia là một ứng dụng giúp sinh viên dễ dàng kết nối với thư viện của trường Đại học Thăng Long và hỗ trợ mượn sách, đặt lịch mượn máy và tổ chức sự kiện,..",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                        color: const Color(0xffECECEC),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "TLUtopia do ai phát triển?",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        Divider(
                          height: 10,
                          color: Colors.transparent,
                        ),
                        Text(
                          "TLUtopia do một nhóm sinh viên Đại học Thăng Long phát triển, chúng tôi sẽ cập nhật phương thức liên lạc sau",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                        color: const Color(0xffECECEC),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tôi có thể báo cáo lỗi ở đâu?",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        Divider(
                          height: 10,
                          color: Colors.transparent,
                        ),
                        Text(
                          "Thông qua Github, bạn có thể báo cáo lỗi ở mục issue found, chúng tôi sẽ nhanh chóng chỉnh sửa",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
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
    return GestureDetector(
      onTap: () => showInformation(context),
      child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xffECECEC),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Câu hỏi thường gặp",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [Text("Bấm để xem chi tiết")],
                  )
                ],
              ),
            ],
          )),
    );
  }
}
