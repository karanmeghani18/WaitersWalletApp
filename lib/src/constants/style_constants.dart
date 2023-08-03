//header style constants
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import 'color_constants.dart';

HeaderStyle calendarHeaderStyle = const HeaderStyle(
  leftIcon: Icon(Icons.arrow_circle_left_outlined),
  rightIcon: Icon(Icons.arrow_circle_right_outlined),
  decoration: BoxDecoration(
    color: Colors.white,
  ),
);

ButtonStyle elevatedButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateColor.resolveWith(
    (states) => skinColorConst.withOpacity(0.8),
  ),
  foregroundColor: MaterialStateColor.resolveWith(
    (states) => Colors.white,
  ),
  textStyle: MaterialStateTextStyle.resolveWith(
    (states) => const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    ),
  ),
);
