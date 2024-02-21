// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:tlutopia/screen/schedule/loanAsk.dart';

class AskingConfiguration extends StatefulWidget {
  const AskingConfiguration({super.key});

  @override
  State<AskingConfiguration> createState() => _AskingConfigurationState();
}

class _AskingConfigurationState extends State<AskingConfiguration> {
  final List<Map<String, dynamic>> content = [
    {
      "title": "TLUtopia là gì?",
      "description":
          "TLUtopia là một ứng dụng giúp sinh viên dễ dàng kết nối với thư viện của trường Đại học Thăng Long và hỗ trợ mượn sách, đặt lịch mượn máy và tổ chức sự kiện,.."
    },
    {
      "title": "Tôi có thể báo cáo lỗi ở đâu?",
      "description":
          "Thông qua Github, bạn có thể báo cáo lỗi ở mục issue found, chúng tôi sẽ nhanh chóng chỉnh sửa."
    },
    {
      "title": "Dữ liệu người dùng có được bảo đảm như thế nào?",
      "description":
          "Chúng tôi sử dụng nhiều biện pháp công nghệ để đảm bảo, bạn có thể đọc thêm tại Developer's Private Policy."
    },
  ];
  void showInformation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: const Column(
                        children: [
                          Text(
                            "Giải đáp thắc mắc",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Divider(
                            height: 5,
                            color: Colors.transparent,
                          ),
                          Text(
                            "Cuộn xuống để xem thêm",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: SingleChildScrollView(
                        child: Column(
                          children: content
                              .map((item) => AskItem(
                                    title: item['title'],
                                    description: item['description'],
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffDAEBFF),
                          shadowColor: Colors.transparent,
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
          ),
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
                    "Giải đáp thắc mắc",
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
