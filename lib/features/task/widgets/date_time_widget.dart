import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeWidget extends StatefulWidget {
  DateTimeWidget({
    super.key,
    this.isDate = false,
    required this.timeVal,
    required this.dateVal,
  });
  final bool isDate;
  TimeOfDay timeVal;
  DateTime dateVal;

  @override
  State<DateTimeWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  var formatter = DateFormat('yyyy-MM-dd');
  void _showDateTimePicker() async {
    final data = await showModalBottomSheet(
      context: context,
      builder: (_) => SizedBox(
        height: 500,
        child: widget.isDate
            ? DatePickerDialog(
                firstDate: DateTime(2023),
                initialDate: widget.dateVal,
                lastDate: DateTime(2026))
            : TimePickerDialog(
                initialTime: widget.timeVal,
              ),
      ),
    );

    if (data != null) {
      if (widget.isDate) {
        widget.dateVal = data;
      } else {
        widget.timeVal = data;
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDateTimePicker(),
      child: Container(
        width: double.infinity,
        height: 55,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                widget.isDate ? "Date" : "Time",
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
            Text(
              widget.isDate
                  ? formatter.format(widget.dateVal)
                  : widget.timeVal.format(context),
              style: const TextStyle(color: Colors.grey, fontSize: 15),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 80,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade100,
              ),
              child: Center(
                child: Text(
                  widget.isDate ? "Date" : "Time",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
