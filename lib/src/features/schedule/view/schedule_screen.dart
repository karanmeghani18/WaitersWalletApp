import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:waiters_wallet/src/features/schedule/controller/schedule_controller.dart';
import 'package:waiters_wallet/src/features/schedule/models/schedule_model.dart';
import '../widgets/schedule_tile.dart';

class ScheduleScreen extends ConsumerStatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> {
  DateTime getWeekStartDate(DateTime date) {
    DateTime weekStart = date.subtract(Duration(days: date.weekday - 1));
    return DateTime(weekStart.year, weekStart.month, weekStart.day);
  }

  DateTime getWeekEndDate(DateTime date) {
    DateTime weekEnd =
        date.add(Duration(days: DateTime.daysPerWeek - date.weekday));
    return DateTime(weekEnd.year, weekEnd.month, weekEnd.day);
  }

  String getFormattedDate(DateTime date) {
    return DateFormat('d/M').format(date);
  }

  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final startDate = getFormattedDate(getWeekStartDate(today));
    final endDate = getFormattedDate(getWeekEndDate(today));
    final weekHeaderString = "$startDate - $endDate";
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    today = today.subtract(const Duration(days: 7));
                  });
                },
                icon: const Icon(Icons.arrow_circle_left_outlined),
              ),
              Text(
                weekHeaderString,
                style: const TextStyle(fontSize: 18),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    today = today.add(const Duration(days: 7));
                  });
                },
                icon: const Icon(Icons.arrow_circle_right_outlined),
              ),
            ],
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(scheduleControllerProvider);
            final schedule = state.schedule;
            return ListView.builder(
             shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final startingDate = getWeekStartDate(today);
                final DateTime currentDate =
                    startingDate.add(Duration(days: index));
                final String dateString =
                    getScheduleFormattedDate(currentDate);
                List<ScheduleModel> result = [];

                for (var s in schedule) {
                  if (s.startOfShift.withoutTime == currentDate.withoutTime) {
                    result.add(s);
                  }
                }
                return Column(
                  children: [
                    ScheduleTile(
                      dateString: dateString,
                      currentDate: currentDate,
                      scheduleModel: result,
                    ),
                  ],
                );
              },
              itemCount: 7,
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  String getScheduleFormattedDate(DateTime date) {
    DateFormat formatter = DateFormat('EEEE, MMMM d');
    return formatter.format(date);
  }
}
