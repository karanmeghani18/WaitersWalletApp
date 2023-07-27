import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiters_wallet/src/features/calendar/controller/calendar_event_controller.dart';
import 'package:waiters_wallet/src/features/goals/controller/goals_controller.dart';
import 'package:waiters_wallet/src/features/goals/widgets/daily_date_selector.dart';
import 'package:waiters_wallet/src/features/goals/widgets/goal_card.dart';
import 'package:waiters_wallet/src/features/goals/widgets/monthly_date_selector.dart';
import 'package:waiters_wallet/src/features/goals/widgets/yearly_date_selector.dart';
import 'package:waiters_wallet/src/widgets/week_dates_selector.dart';

import '../../../utils/utils.dart';
import '../../addtip/models/tip_model.dart';

class GoalTracker extends ConsumerStatefulWidget {
  const GoalTracker({
    Key? key,
    required this.tabIndex,
  }) : super(key: key);

  final int tabIndex;

  @override
  ConsumerState<GoalTracker> createState() => _GoalTrackerState();
}

class _GoalTrackerState extends ConsumerState<GoalTracker> {
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
    final goals = ref.watch(goalsControllerProvider).goals;
    final goalsAvailable = goals != null;
    TipModel? tipsOfTheDay = ref
        .watch(calendarEventControllerProvider.notifier)
        .getEarningsOfDay(selectedDate);


    return goalsAvailable
        ? SingleChildScrollView(
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
                GoalCard(
                  title: "Take Home",
                  goal: goals.takeHomeGoal,
                  value: widget.tabIndex == 0
                      ? tipsOfTheDay?.takeHome ?? 0.0
                      : 0.0,
                ),
                GoalCard(
                  title: "Hours",
                  goal: goals.hoursGoal,
                  value: widget.tabIndex == 0
                      ? tipsOfTheDay?.hoursWorked ?? 0.0
                      : 0.0,
                ),
                GoalCard(
                  title: "Average Hourly",
                  goal: goals.averageHourlyGoal,
                  value: widget.tabIndex == 0
                      ? tipsOfTheDay != null
                          ? tipsOfTheDay.takeHome / tipsOfTheDay.hoursWorked
                          : 0.0
                      : 0.0,
                ),
              ],
            ),
          )
        : const Center(
            child: Text(
              "Add Goals To Track Your Earnings",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
