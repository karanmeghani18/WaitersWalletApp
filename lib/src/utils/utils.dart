import 'package:intl/intl.dart';

DateTime getWeekStartDate(DateTime date) {
  DateTime weekStart = date.subtract(Duration(days: date.weekday - 1));
  return DateTime(weekStart.year, weekStart.month, weekStart.day);
}

DateTime getWeekEndDate(DateTime date) {
  DateTime weekEnd =
  date.add(Duration(days: DateTime.daysPerWeek - date.weekday));
  return DateTime(weekEnd.year, weekEnd.month, weekEnd.day);
}

String getFormattedDate(DateTime date) {
  return DateFormat('d/M/yy').format(date);
}