import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tlutopia/screen/firstScreen/register_screen.dart';

class Information extends StatefulWidget {
  final String studentName;
  final String studentCode;
  final String studentPhoneNum;
  final IconData icon = Icons.person_rounded;

  Information({
    required this.studentName,
    required this.studentCode,
    required this.studentPhoneNum,
    Key? key,
  }) : super(key: key);

  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        showChangeInformationModal(context, widget.studentCode);
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffECECEC),
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: const EdgeInsets.fromLTRB(40, 15, 40, 5),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 45,
                color: const Color.fromARGB(221, 72, 72, 72),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.studentName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "${widget.studentCode} | ${widget.studentPhoneNum}",
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showChangeInformationModal(BuildContext context, String studentCode) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: ChangeInformationForm(studentCode: studentCode),
        );
      },
    );
  }
}

class ChangeInformationForm extends StatefulWidget {
  final String studentCode;

  const ChangeInformationForm({required this.studentCode, Key? key})
      : super(key: key);

  @override
  _ChangeInformationFormState createState() => _ChangeInformationFormState();
}

class _ChangeInformationFormState extends State<ChangeInformationForm> {
  final TextEditingController studentPass = TextEditingController();
  final TextEditingController studentNewPass = TextEditingController();
  final TextEditingController studentReNewPass = TextEditingController();
  bool success = false;

  Future<void> fetchData() async {
    if ((studentNewPass.text != studentReNewPass.text) ||
        studentNewPass.text.isEmpty ||
        studentReNewPass.text.isEmpty) {
      return;
    }
    setState(() {
      success = true;
    });
    var url = Uri.parse('http://192.168.1.10/aserver/update.php');
    var data = {
      'studentCode': widget.studentCode,
      'studentPass': studentPass.text,
      'studentNewPass': studentNewPass.text,
    };

    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Thay đổi thành công!'),
        ),
      ); // Close the modal
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(
              height: 20,
              color: Colors.transparent,
            ),
            const Text(
              "Đổi thông tin: ",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            InputField(
                controller: studentPass,
                description: "Nhập mật khẩu cũ:",
                hideText: true),
            InputField(
                controller: studentNewPass,
                description: "Nhập mật khẩu mới:",
                hideText: true),
            InputField(
                controller: studentReNewPass,
                description: "Xác nhận mật khẩu mới:",
                hideText: true),
            const Divider(
              height: 20,
              color: Colors.transparent,
            ),
            ElevatedButton(
              onPressed: () {
                fetchData();
                if (success) Navigator.of(context).pop();
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Color(0xffDAEBFF)),
                maximumSize: MaterialStatePropertyAll(Size(300, 500)),
                shadowColor: MaterialStatePropertyAll(Colors.transparent),
              ),
              child: const Text(
                'Xác nhận',
                style: TextStyle(
                  color: Color(0xff3184FF),
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
