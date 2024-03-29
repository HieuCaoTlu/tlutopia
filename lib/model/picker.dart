// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SetTime extends StatefulWidget {
  DateTime select;
  final Function(DateTime) onDateChanged;

  SetTime({super.key, required this.select, required this.onDateChanged});

  @override
  SetTimeState createState() => SetTimeState();
}

class SetTimeState extends State<SetTime> {
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.select,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != widget.select) {
      widget.onDateChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
      // _selectDate(context)
      },
      style: const ButtonStyle(
          shadowColor: MaterialStatePropertyAll(Colors.transparent),
          backgroundColor: MaterialStatePropertyAll(Color(0xffECECEC))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 12, 5, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat('d/M', 'vi_VN').format(widget.select),
              style: const TextStyle(
                  fontSize: 17, color: Colors.black, fontWeight: FontWeight.w600),
            ),
            // const SizedBox(
            //   width: 5,
            // ),
            // const Text(
            //   "đổi",
            //   style: TextStyle(fontSize: 14, color: Colors.black),
            // )
          ],
        ),
      ),
    );
  }
}
