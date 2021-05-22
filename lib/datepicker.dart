import 'package:flutter/material.dart';

class DatePickerDemo extends StatefulWidget {
  @override
  _DatePickerDemoState createState() => _DatePickerDemoState();
}

class _DatePickerDemoState extends State<DatePickerDemo> {
  /// Which holds the selected date
  /// Defaults to today's date.
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          "${selectedDate.toLocal()}".split(' ')[0],
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        RaisedButton(
          onPressed: () => _selectDate(context),
          child: Text(
            'Select date',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          color: Colors.greenAccent,
        ),
      ],
    );
  }
}
