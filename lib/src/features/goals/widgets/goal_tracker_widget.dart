import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiters_wallet/src/features/goals/controller/goals_controller.dart';
import 'package:waiters_wallet/src/features/goals/models/goals_model.dart';
import 'package:waiters_wallet/src/features/goals/widgets/daily_date_selector.dart';
import 'package:waiters_wallet/src/features/goals/widgets/goal_card.dart';
import 'package:waiters_wallet/src/features/goals/widgets/monthly_date_selector.dart';
import 'package:waiters_wallet/src/features/goals/widgets/yearly_date_selector.dart';
import 'package:waiters_wallet/src/widgets/week_dates_selector.dart';

import '../../../utils/utils.dart';

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

  double getTakeHomeData() {
    final takeHomeGoal = ref.read(goalsControllerProvider).goals!.takeHomeGoal;
    final goalType = ref.read(goalsControllerProvider).goals!.goalType;
    switch (widget.tabIndex) {
      case 0:
        double result =
            goalType == GoalType.weekly ? takeHomeGoal / 7 : takeHomeGoal / 30;
        return double.parse(result.toStringAsFixed(2));
      case 1:
        double result =
            goalType == GoalType.weekly ? takeHomeGoal : takeHomeGoal / 4;
        return double.parse(result.toStringAsFixed(2));
      case 2:
        double result =
            goalType == GoalType.weekly ? takeHomeGoal * 4 : takeHomeGoal;
        return double.parse(result.toStringAsFixed(2));
      case 3:
        double result =
            goalType == GoalType.weekly ? takeHomeGoal * 52 : takeHomeGoal * 12;
        return double.parse(result.toStringAsFixed(2));
      default:
        return 0.0;
    }
  }

  double getHoursData() {
    final hoursGoal = ref.read(goalsControllerProvider).goals!.hoursGoal;
    final goalType = ref.read(goalsControllerProvider).goals!.goalType;
    switch (widget.tabIndex) {
      case 0:
        double result =
            goalType == GoalType.weekly ? hoursGoal / 7 : hoursGoal / 30;
        return double.parse(result.toStringAsFixed(2));
      case 1:
        double result = goalType == GoalType.weekly ? hoursGoal : hoursGoal / 4;
        return double.parse(result.toStringAsFixed(2));
      case 2:
        double result = goalType == GoalType.weekly ? hoursGoal * 4 : hoursGoal;
        return double.parse(result.toStringAsFixed(2));
      case 3:
        double result =
            goalType == GoalType.weekly ? hoursGoal * 52 : hoursGoal * 12;
        return double.parse(result.toStringAsFixed(2));
      default:
        return 0.0;
    }
  }



  @override
  Widget build(BuildContext context) {
    final startDate = getFormattedDate(getWeekStartDate(selectedDate));
    final endDate = getFormattedDate(getWeekEndDate(selectedDate));
    final weekHeaderString = "$startDate - $endDate";
    final goals = ref.watch(goalsControllerProvider).goals;
    final goalsAvailable = goals != null;

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
                  goal: getTakeHomeData(),
                  value: 0.0,
                ),
                GoalCard(
                  title: "Hours",
                  goal: getHoursData(),
                  value: 0.0,
                ),
                GoalCard(
                  title: "Average Hourly",
                  goal: double.parse(
                      (getTakeHomeData() / getHoursData()).toStringAsFixed(2)),
                  value: 0.0,
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
