import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SetTime extends StatefulWidget {
  DateTime select;
  final Function(DateTime) onDateChanged;

  SetTime({required this.select, required this.onDateChanged});

  @override
  _SetTimeState createState() => _SetTimeState();
}

class _SetTimeState extends State<SetTime> {
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.select ?? DateTime.now(),
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
      onPressed: () => _selectDate(context),
      style: const ButtonStyle(
          shadowColor: MaterialStatePropertyAll(Colors.transparent),
          backgroundColor: MaterialStatePropertyAll(Color(0xffECECEC))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 12, 5, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat('EEEE', 'vi_VN').format(widget.select),
              style: const TextStyle(
                  fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 15,
            ),
            const Text(
              "đổi",
              style: TextStyle(fontSize: 15, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
