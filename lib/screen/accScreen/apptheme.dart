import 'package:flutter/material.dart';

class AppTheme extends StatelessWidget {
  final String title = 'Chủ đề: TLU';
  // final String detail;
  final String source = 'Bấm để chọn chủ đề khác';
  final IconData icon = Icons.light_mode_rounded;
  const AppTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                icon,
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
                    title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    source,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
