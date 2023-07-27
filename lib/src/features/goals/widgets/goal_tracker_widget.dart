import 'package:flutter/material.dart';
import 'package:waiters_wallet/src/features/goals/widgets/daily_date_selector.dart';
import 'package:waiters_wallet/src/features/goals/widgets/goal_card.dart';
import 'package:waiters_wallet/src/features/goals/widgets/monthly_date_selector.dart';
import 'package:waiters_wallet/src/features/goals/widgets/yearly_date_selector.dart';
import 'package:waiters_wallet/src/widgets/week_dates_selector.dart';

import '../../../utils/utils.dart';

class GoalTracker extends StatefulWidget {
  const GoalTracker({
    Key? key,
    required this.tabIndex,
  }) : super(key: key);

  final int tabIndex;

  @override
  State<GoalTracker> createState() => _GoalTrackerState();
}

class _GoalTrackerState extends State<GoalTracker> {
  DateTime selectedDate = DateTime.now();

  void _incrementDate(int days) {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: days));
    });
  }

  void _decrementDate(int days) {
    setState(() {
      selectedDate = selectedDate.subtract(Duration(days: days));
    });
  }

  @override
  Widget build(BuildContext context) {
    final startDate = getFormattedDate(getWeekStartDate(selectedDate));
    final endDate = getFormattedDate(getWeekEndDate(selectedDate));
    final weekHeaderString = "$startDate - $endDate";

    return SingleChildScrollView(
      child: Column(
        children: [
          if (widget.tabIndex == 0)
            DailyDateSelector(
              selectedDate: selectedDate,
              onLeftArrowPress: () => _decrementDate(1),
              onRightArrowPress: () => _incrementDate(1),
            ),
          if (widget.tabIndex == 1)
            WeekDateSelector(
              today: selectedDate,
              weekHeaderString: weekHeaderString,
              onLeftArrowPress: () => _decrementDate(7),
              onRightArrowPress: () => _incrementDate(7),
            ),
          if (widget.tabIndex == 2)
            MonthlyDateSelector(
              selectedDate: selectedDate,
              onLeftArrowPress: () => _decrementDate(30),
              onRightArrowPress: () => _incrementDate(30),
            ),
          if (widget.tabIndex == 3)
            YearlyDateSelector(
              selectedDate: selectedDate,
              onLeftArrowPress: () => _decrementDate(365),
              onRightArrowPress: () => _incrementDate(365),
            ),
          const GoalCard(title: "Take Home", goal: 100, value: 110),
          const GoalCard(title: "Hours", goal: 100, value: 30),
          const GoalCard(title: "Average Hourly", goal: 100, value: 60),
        ],
      ),
    );
  }
}
