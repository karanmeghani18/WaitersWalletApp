import 'package:flutter/material.dart';
import 'package:waiters_wallet/src/features/goals/widgets/goal_card.dart';

class GoalTracker extends StatelessWidget {
  const GoalTracker({
    Key? key,
    required this.tabIndex,
  }) : super(key: key);

  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          GoalCard(title: "Take Home", goal: 100, value: 110),
          GoalCard(title: "Hours", goal: 100, value: 30),
          GoalCard(title: "Average Hourly", goal: 100, value: 60),
        ],
      ),
    );
  }
}


