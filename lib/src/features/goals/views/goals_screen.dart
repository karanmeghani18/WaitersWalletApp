import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiters_wallet/src/features/goals/widgets/goals_chart.dart';

import '../../calendar/controller/calendar_event_controller.dart';

class GoalsScreen extends ConsumerStatefulWidget {
  const GoalsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends ConsumerState<GoalsScreen> {
  List<double> weekData = [];

  DateTime selectedWeekDate = DateTime.now();
  int weekBackArrowTap = 0;
  int weekFrontArrowTap = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    weekData = ref
        .watch(calendarEventControllerProvider.notifier)
        .getWeekEarningsData(weekBackArrowTap, weekFrontArrowTap);
  }

  @override
  void initState() {
    super.initState();
    weekData = ref
        .read(calendarEventControllerProvider.notifier)
        .getWeekEarningsData(weekBackArrowTap, weekFrontArrowTap);
  }

  String getWeekOfMonth(DateTime date) {
    int firstDayOfMonth = DateTime(date.year, date.month, 1).weekday;
    int weekOfMonth = ((date.day + firstDayOfMonth - 2) / 7).ceil();
    return weekOfMonth.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 14, bottom: 20),
            child: Text(
              "Goals",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  weekBackArrowTap++;
                  selectedWeekDate =
                      selectedWeekDate.subtract(const Duration(days: 7));
                  weekData = ref
                      .watch(calendarEventControllerProvider.notifier)
                      .getWeekEarningsData(weekBackArrowTap, weekFrontArrowTap);
                });
              },
              icon: const Icon(Icons.arrow_circle_left_outlined),
              padding: EdgeInsets.zero,
            ),
            Spacer(),
            Text(
              "${selectedWeekDate.month}-${getWeekOfMonth(selectedWeekDate)}",
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                setState(() {
                  weekFrontArrowTap++;
                  selectedWeekDate =
                      selectedWeekDate.add(const Duration(days: 7));
                  weekData = ref
                      .watch(calendarEventControllerProvider.notifier)
                      .getWeekEarningsData(weekBackArrowTap, weekFrontArrowTap);
                });
              },
              icon: const Icon(Icons.arrow_circle_right_outlined),
              padding: EdgeInsets.zero,
            ),
          ],
        ),
        GoalsChart(),
      ],
    );
  }
}
