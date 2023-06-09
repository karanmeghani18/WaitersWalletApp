import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:waiters_wallet/src/constants/color_constants.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  bool isCustomDay = false;
  DateTime selectedDate = DateTime.now();

  Color decideCellColor(DateTime cellDate, bool isToday, bool isInMonth){
    if(!isInMonth){
       return Colors.grey.withOpacity(0.1);
    }else{
      if(cellDate.withoutTime == selectedDate.withoutTime){
        return skinColorConst;
      }
      return Colors.transparent;
    }
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MonthView(
        controller: EventController(),
        onCellTap: (events, date) {
          print(date);
          print(events);
          setState(() {
            isCustomDay = true;
            selectedDate = date;
          });
        },
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
                  color: !isInMonth
                          ? Colors.grey.withOpacity(0.7)
                          : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
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
