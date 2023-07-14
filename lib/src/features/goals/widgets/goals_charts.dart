import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:waiters_wallet/src/constants/color_constants.dart';

import '../../addtip/models/tip_model.dart';

// ...

class GoalsPieChart extends StatefulWidget {
  final String title;
  final List<TipModel> tipData;

  const GoalsPieChart({super.key, required this.title, required this.tipData});

  @override
  State<GoalsPieChart> createState() => _GoalsPieChartState();
}

class _GoalsPieChartState extends State<GoalsPieChart> {
  final double takeHomeDailyGoal = 100;
  final hoursDailyGoal = 4;
  final averageHourlyTipDailyGoal = 15;

  @override
  Widget build(BuildContext context) {
    return SimpleCircularProgressBar(
      mergeMode: true,
      progressColors: [skinColorConst],
      backColor: Colors.transparent,
      size: 140,
      valueNotifier: ValueNotifier(
          widget.tipData.first.takeHome >= takeHomeDailyGoal
              ? 100
              : (widget.tipData.first.takeHome / takeHomeDailyGoal) * 100),
      animationDuration: 1,
      onGetText: (double value) {
        TextStyle centerTextStyle = TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: skyBlueColorConst,
        );

        return Text(
          '${value.toInt()}%',
          style: centerTextStyle,
        );
      },
    );
  }
}
