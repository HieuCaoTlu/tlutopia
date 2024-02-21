// ignore_for_file: file_names
import 'package:flutter/material.dart';

class LoanQuestions extends StatelessWidget {
  const LoanQuestions({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> content = [
      {
        "title": "Sau khi đặt lịch thì cần làm gì?",
        "description":
            "Bạn hãy đến thư viện và tới quầy thủ thư để nhận sách đã mượn trong lịch"
      },
      {
        "title": "Nếu tạo nhiều lịch mượn trong cùng một ngày thì sao?",
        "description":
            "Những lịch mượn đó sẽ được gộp vào làm một để bạn tiện theo dõi"
      },
      {
        "title": "Được phép mượn bao nhiêu sách trong một lần đặt lịch?",
        "description": "Bạn chỉ được mượn cùng một lúc tối đa 5 quyển sách"
      },
      {
        "title": "Có cách nào để gia hạn lịch mượn sách không?",
        "description":
            "Bạn hãy liên hệ trực tiếp với thủ thư để được trợ giúp, việc bạn được gia hạn sẽ tùy thuộc vào chính sách của thư viện"
      },
    ];
    return GestureDetector(
      onTap: () {
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
                                "Câu hỏi thường gặp",
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
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.1,
        height: MediaQuery.of(context).size.height * 0.1,
        margin: const EdgeInsets.only(right: 10),
        decoration: const BoxDecoration(
          color: Color(0xffECECEC),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.question_mark_rounded,
          color: Colors.black,
        ),
      ),
    );
  }
}

class AskItem extends StatelessWidget {
  final String title;
  final String description;

  const AskItem({
    required this.title,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: const Color(0xffECECEC),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          const Divider(
            height: 10,
            color: Colors.transparent,
          ),
          Text(
            description,
            textAlign: TextAlign.justify,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
