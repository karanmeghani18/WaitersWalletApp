import 'package:flutter/material.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({
    super.key,
    required this.date,
    required this.isInMonth,
    required this.hasEvent,
  });

  final DateTime date;
  final bool isInMonth;
  final bool hasEvent;

  @override
  Widget build(BuildContext context) {
    return Text(
      date.day.toString(),
      style: TextStyle(
        color: !isInMonth ? Colors.grey.withOpacity(0.7) : Colors.black,
        fontWeight: FontWeight.bold,
        fontStyle: hasEvent ? FontStyle.italic : null,
      ),
    );
  }
}
