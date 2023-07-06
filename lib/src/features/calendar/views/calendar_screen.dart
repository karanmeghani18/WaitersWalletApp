import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:waiters_wallet/src/features/authentication/controller/auth_controller.dart';
import 'package:waiters_wallet/src/features/calendar/controller/calendar_event_controller.dart';
import 'package:waiters_wallet/src/features/calendar/widgets/widgets.dart';

import 'package:waiters_wallet/src/constants/constants.dart';
import 'package:waiters_wallet/src/widgets/earnings_title.dart';

import '../../addtip/models/restaurant_model.dart';
import '../../addtip/views/addtip_screen.dart';
import '../../restaurants/addrestaurant/controller/addrestaurant_controller.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  bool isCustomDay = false;
  DateTime selectedDate = DateTime.now();
  List<RestaurantModel> restaurants = [];
  double monthlyTakeHome = 0.0;
  double monthlyHours = 0.0;

  Color decideCellColor(DateTime cellDate, bool isToday, bool isInMonth) {
    if (!isInMonth) {
      return Colors.grey.withOpacity(0.1);
    } else {
      if (cellDate.withoutTime == selectedDate.withoutTime) {
        return skinColorConst;
      }
      return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authControllerProvider, (previous, next) {
      if (next.status == AuthStatus.loginUserSuccess) {
        restaurants = ref
            .watch(addRestaurantControllerProvider.notifier)
            .getRestaurants();
      }
    });
    restaurants =
        ref.watch(addRestaurantControllerProvider.notifier).getRestaurants();
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 70,
              child: EarningsTile(
                takeHome: ref
                    .watch(calendarEventControllerProvider.notifier)
                    .calculateMonthlyTakeHome(selectedDate),
                hours: ref
                    .watch(calendarEventControllerProvider.notifier)
                    .calculateMonthlyHours(selectedDate),
              ),
            ),
            Expanded(
              child: MonthView(
                onPageChange: (date, page) {
                  selectedDate = date;
                  setState(() {});
                },
                controller: ref
                    .read(calendarEventControllerProvider.notifier)
                    .eventController,
                onCellTap: (events, date) {
                  if (selectedDate.month == date.month) {
                    setState(() {
                      isCustomDay = true;
                      selectedDate = date;
                    });
                  }
                },
                cellAspectRatio: 1.25,
                cellBuilder: (date, event, isToday, isInMonth) {
                  final bool hasEvent = event.isNotEmpty;
                  double totalTip = 0.0;
                  for (var e in event) {
                    final total = double.parse(e.title);
                    totalTip += total;
                  }
                  return CustomDateCell(
                    hasEvent: hasEvent,
                    cellColor: decideCellColor(date, isToday, isInMonth),
                    isInMonth: isInMonth,
                    date: date,
                    eventTitle: hasEvent ? "$totalTip" : "",
                  );
                },
                headerStyle: calendarHeaderStyle,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: ref
                    .watch(calendarEventControllerProvider)
                    .tips
                    .where((element) =>
                        element.fullDateTime.withoutTime ==
                        selectedDate.withoutTime)
                    .length,
                itemBuilder: (context, index) {
                  final state = ref.watch(calendarEventControllerProvider);
                  final tipsList = state.tips
                      .where((element) =>
                          element.fullDateTime.withoutTime ==
                          selectedDate.withoutTime)
                      .toList();
                  final tip = tipsList[index];
                  return TipTile(
                    onTap: () {
                      showBarModalBottomSheet(
                        context: context,
                        builder: (context) => AddTipSheet(
                          dateTime: selectedDate,
                          tipModel: tip,
                        ),
                      );
                    },
                    restaurantName: restaurants
                        .firstWhere((element) => element.id == tip.restaurantId)
                        .restaurantName,
                    hoursWorked: tip.hoursWorked,
                    tipAmount: tip.takeHome,
                    onDismiss: () {
                      CalendarControllerProvider.of(context)
                          .controller
                          .removeWhere((element) => element.event == tip.id);
                    },
                    confirmDismiss: () async {
                      ref
                          .read(calendarEventControllerProvider.notifier)
                          .deleteTip(tip.id);
                      return true;
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AddTipButton(selectedDate: selectedDate),
    );
  }
}
