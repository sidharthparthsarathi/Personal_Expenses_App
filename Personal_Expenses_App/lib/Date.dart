
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class ADate extends StatelessWidget {
  final DateTime date;
  ADate(this.date);
  @override
  Widget build(BuildContext context) {
    print('Date');
    return Text(DateFormat.yMMMMd().format(date),
    );
  }
}