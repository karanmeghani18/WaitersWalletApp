import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiters_wallet/src/features/earnings/widgets/earings_chart.dart';
import 'package:waiters_wallet/src/features/earnings/widgets/period_slider.dart';

import '../../addtip/models/restaurant_model.dart';
import '../../calendar/controller/calendar_event_controller.dart';
import '../../calendar/widgets/tip_tile.dart';
import '../../restaurants/addrestaurant/controller/addrestaurant_controller.dart';

class EarningsScreen extends ConsumerStatefulWidget {
  const EarningsScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _EarningsScreenState();
}

class _EarningsScreenState extends ConsumerState<EarningsScreen> {
  int groupValue = 0;
  List<double> weekData = [];
  List<double> monthData = [];

  int weekBackArrowTap = 0;
  int weekFrontArrowTap = 0;

  DateTime selectedDate = DateTime.now();
  DateTime selectedWeekDate = DateTime.now();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    weekData = ref
        .watch(calendarEventControllerProvider.notifier)
        .getWeekEarningsData(weekBackArrowTap, weekFrontArrowTap);
    monthData = ref
        .watch(calendarEventControllerProvider.notifier)
        .getMonthEarningsData(selectedDate);
  }

  @override
  void initState() {
    super.initState();
    weekData = ref
        .read(calendarEventControllerProvider.notifier)
        .getWeekEarningsData(weekBackArrowTap, weekFrontArrowTap);
    monthData = ref
        .read(calendarEventControllerProvider.notifier)
        .getMonthEarningsData(selectedDate);
  }

  String getWeekOfMonth(DateTime date) {
    int firstDayOfMonth = DateTime(date.year, date.month, 1).weekday;
    int weekOfMonth = ((date.day + firstDayOfMonth - 2) / 7).ceil();
    return weekOfMonth.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 24, bottom: 10),
            child: Text(
              "Earnings",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (groupValue == 0) {
                    weekBackArrowTap++;
                    selectedWeekDate =
                        selectedWeekDate.subtract(const Duration(days: 7));
                    weekData = ref
                        .watch(calendarEventControllerProvider.notifier)
                        .getWeekEarningsData(
                            weekBackArrowTap, weekFrontArrowTap);
                  } else {
                    selectedDate =
                        DateTime(selectedDate.year - 1, selectedDate.month);
                    monthData = ref
                        .watch(calendarEventControllerProvider.notifier)
                        .getMonthEarningsData(selectedDate);
                  }
                });
              },
              icon: const Icon(Icons.arrow_circle_left_outlined),
              padding: EdgeInsets.zero,
            ),
            Spacer(),
            Text(groupValue == 1
                ? selectedDate.year.toString()
                : "${selectedWeekDate.month}-${getWeekOfMonth(selectedWeekDate)}"),
            Spacer(),
            IconButton(
              onPressed: () {
                setState(() {
                  if (groupValue == 0) {
                    weekFrontArrowTap++;
                    selectedWeekDate =
                        selectedWeekDate.add(const Duration(days: 7));
                    weekData = ref
                        .watch(calendarEventControllerProvider.notifier)
                        .getWeekEarningsData(
                            weekBackArrowTap, weekFrontArrowTap);
                  } else {
                    selectedDate =
                        DateTime(selectedDate.year + 1, selectedDate.month);
                    monthData = ref
                        .watch(calendarEventControllerProvider.notifier)
                        .getMonthEarningsData(selectedDate);
                  }
                });
              },
              icon: const Icon(Icons.arrow_circle_right_outlined),
              padding: EdgeInsets.zero,
            ),
          ],
        ),
        EarningsChart(
          chartLevel: groupValue,
          weekdata: weekData,
          monthdata: monthData,
        ),
        PeriodSlider(
          onValueChanged: (value) {
            setState(() {
              groupValue = value!;
            });
          },
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: ref
                .watch(addRestaurantControllerProvider.notifier)
                .getRestaurants()
                .length,
            itemBuilder: (context, index) {
              final List<RestaurantModel> restaurantsList = ref
                  .watch(addRestaurantControllerProvider.notifier)
                  .getRestaurants();
              final restaurant = restaurantsList[index];
              var earningsMap = {};
              if (groupValue == 0) {
                earningsMap = ref
                    .watch(calendarEventControllerProvider.notifier)
                    .getWeeklyRestaurantTotals(
                        weekBackArrowTap, weekFrontArrowTap);
              } else {
                earningsMap = ref
                    .watch(calendarEventControllerProvider.notifier)
                    .getRestaurantTotalsByMonth(selectedDate.year);
              }

              print(earningsMap);

              return TipTile(
                restaurantName: restaurant.restaurantName,
                hoursWorked: groupValue == 0
                    ? (earningsMap[restaurant.id] != null
                        ? earningsMap[restaurant.id]!['hoursWorkedTotal'] ?? 0.0
                        : 0.0)
                    : (earningsMap[
                                "${selectedDate.year}-${selectedDate.month}"] !=
                            null
                        ? earningsMap["${selectedDate.year}-${selectedDate.month}"]![
                                    restaurant.id] !=
                                null
                            ? earningsMap[
                                        "${selectedDate.year}-${selectedDate.month}"]![
                                    restaurant.id]!['hoursWorkedTotal'] ??
                                0.0
                            : 0.0
                        : 0.0),
                tipAmount: groupValue == 0
                    ? (earningsMap[restaurant.id] != null
                        ? earningsMap[restaurant.id]!['takeHomeTotal'] ?? 0.0
                        : 0.0)
                    : (earningsMap[
                                "${selectedDate.year}-${selectedDate.month}"] !=
                            null
                        ? earningsMap["${selectedDate.year}-${selectedDate.month}"]![
                                    restaurant.id] !=
                                null
                            ? earningsMap[
                                        "${selectedDate.year}-${selectedDate.month}"]![
                                    restaurant.id]!['takeHomeTotal'] ??
                                0.0
                            : 0.0
                        : 0.0),
                  onDismiss: () {},
                confirmDismiss: () async {
                  return false;
                },
                onTap: () {},
              );
            },
          ),
        ),
      ],
    );
  }
}
