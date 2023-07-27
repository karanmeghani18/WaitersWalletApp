import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:waiters_wallet/src/constants/color_constants.dart';

class GoalsProgressCircle extends StatefulWidget {
  final double value;
  final double goal;

  const GoalsProgressCircle({
    super.key,
    required this.value,
    required this.goal,
  });

  @override
  State<GoalsProgressCircle> createState() => _GoalsProgressCircleState();
}

class _GoalsProgressCircleState extends State<GoalsProgressCircle> {
  @override
  Widget build(BuildContext context) {
    return SimpleCircularProgressBar(
      mergeMode: true,
      progressColors: [skinColorConst, skyBlueColorConst],
      backColor: Colors.grey,
      size: 120,
      fullProgressColor: greenColorConst,
      valueNotifier: ValueNotifier(
        widget.value >= widget.goal ? 100 : (widget.value / widget.goal) * 100,
      ),
      animationDuration: 2,
      backStrokeWidth: 10,
      progressStrokeWidth: 12,
      onGetText: (double value) {
        return Text(
          '${value.toInt()}%',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: value == 100.0
                ? greenColorConst
                : value <= 40
                    ? Colors.red
                    : yellowColorConst,
          ),
        );
      },
    );
  }
}
