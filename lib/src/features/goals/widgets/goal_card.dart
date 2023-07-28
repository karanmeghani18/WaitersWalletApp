import 'package:flutter/material.dart';
import 'package:waiters_wallet/src/constants/color_constants.dart';

import 'goal_progress_circle.dart';

class GoalCard extends StatelessWidget {
  const GoalCard({
    super.key,
    required this.title,
    required this.goal,
    required this.value,
  });

  final String title;
  final double value;
  final double goal;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.only(top: 18, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            offset: const Offset(1, 5),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          GoalsProgressCircle(value: value, goal: goal),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 10,
                width: 40,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    skyBlueColorConst,
                    skinColorConst,
                  ],
                )),
              ),
              Text("So far: $value"),
              const SizedBox(width: 10),
              Container(
                margin: const EdgeInsets.only(right: 10),
                height: 10,
                width: 40,
                color: Colors.grey,
              ),
              Text("Remaining: ${value < goal ? goal - value : 0}"),
            ],
          ),
        ],
      ),
    );
  }
}
