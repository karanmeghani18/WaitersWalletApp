import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:waiters_wallet/src/constants/color_constants.dart';

import '../../addtip/views/addtip_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
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
              controller: EventController(),
              onCellTap: (events, date) {
                setState(() {
                  isCustomDay = true;
                  selectedDate = date;
                });
              },
              cellAspectRatio: 1.1,
              cellBuilder: (date, event, isToday, isInMonth) {
                return Container(
                  decoration: BoxDecoration(
                    color: decideCellColor(date, isToday, isInMonth),
                    // borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(
                        color:
                            !isInMonth ? Colors.grey.withOpacity(0.7) : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
              headerStyle: const HeaderStyle(
                leftIcon: Icon(Icons.arrow_circle_left_outlined),
                rightIcon: Icon(Icons.arrow_circle_right_outlined),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showBarModalBottomSheet(
            context: context,
            builder: (context) => const AddTipSheet(),
           
          );
        },
        backgroundColor: skinColorConst,
        icon: const Icon(Icons.add),
        label: const Text(
          'Add',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

