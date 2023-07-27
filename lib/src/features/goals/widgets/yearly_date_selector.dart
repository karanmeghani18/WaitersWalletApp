import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class YearlyDateSelector extends StatelessWidget {
  const YearlyDateSelector({
    Key? key,
    required this.selectedDate,
    required this.onLeftArrowPress,
    required this.onRightArrowPress,
  }) : super(key: key);

  final DateTime selectedDate;
  final VoidCallback onLeftArrowPress;
  final VoidCallback onRightArrowPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => onLeftArrowPress(),
          icon: const Icon(Icons.arrow_circle_left_outlined),
          padding: EdgeInsets.zero,
        ),
        Text(
          DateFormat('y').format(selectedDate),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        IconButton(
          onPressed: () => onRightArrowPress(),
          icon: const Icon(Icons.arrow_circle_right_outlined),
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}
