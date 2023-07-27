import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeekDateSelector extends StatelessWidget {
  const WeekDateSelector({
    Key? key,
    required this.today,
    required this.onLeftArrowPress,
    required this.onRightArrowPress,
    required this.weekHeaderString,
  }) : super(key: key);

  final DateTime today;
  final VoidCallback onLeftArrowPress;
  final VoidCallback onRightArrowPress;
  final String weekHeaderString;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => onLeftArrowPress(),
          icon: const Icon(Icons.arrow_circle_left_outlined),
        ),
        Text(
          weekHeaderString,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          onPressed: () => onRightArrowPress(),
          icon: const Icon(Icons.arrow_circle_right_outlined),
        ),
      ],
    );
  }
}
