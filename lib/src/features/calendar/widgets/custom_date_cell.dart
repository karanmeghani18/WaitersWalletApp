import 'package:flutter/material.dart';
import 'package:waiters_wallet/src/features/calendar/widgets/widgets.dart';

class CustomDateCell extends StatelessWidget {
  const CustomDateCell({
    Key? key,
    required this.hasEvent,
    required this.cellColor,
    required this.isInMonth,
    required this.date,
    required this.eventTitle,
  }) : super(key: key);

  final Color cellColor;
  final DateTime date;
  final bool isInMonth;
  final bool hasEvent;
  final String eventTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cellColor,
        // borderRadius: BorderRadius.circular(10),
      ),
      child: !hasEvent
          ? Center(
              child: DateWidget(
                date: date,
                isInMonth: isInMonth,
                hasEvent: hasEvent,
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DateWidget(
                  date: date,
                  isInMonth: isInMonth,
                  hasEvent: hasEvent,
                ),
                Text("\$ $eventTitle"),
              ],
            ),
    );
  }
}
