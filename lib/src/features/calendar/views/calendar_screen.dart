import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiters_wallet/src/features/calendar/controller/calendar_event_controller.dart';
import 'package:waiters_wallet/src/features/calendar/widgets/widgets.dart';

import 'package:waiters_wallet/src/constants/constants.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  bool isCustomDay = false;
  DateTime selectedDate = DateTime.now();

  Color decideCellColor(DateTime cellDate, bool isToday, bool isInMonth) {
    if (!isInMonth) {
      return Colors.grey.withOpacity(0.1);
    } else {
      if (cellDate.withoutTime == selectedDate.withoutTime) {
        return skinColorConst;
      }
      return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: MonthView(
              controller: ref
                  .read(calendarEventControllerProvider.notifier)
                  .eventController,
              onCellTap: (events, date) {
                setState(() {
                  isCustomDay = true;
                  selectedDate = date;
                });
              },
              cellAspectRatio: 1.1,
              cellBuilder: (date, event, isToday, isInMonth) {
                final bool hasEvent = event.isNotEmpty;
                return CustomDateCell(
                  hasEvent: hasEvent,
                  cellColor: decideCellColor(date, isToday, isInMonth),
                  isInMonth: isInMonth,
                  date: date,
                  eventTitle: hasEvent ? event.first.title : "",
                );
              },
              headerStyle: calendarHeaderStyle,
            ),
          ),
        ],
      ),
      floatingActionButton: AddTipButton(selectedDate: selectedDate),
    );
  }
}
