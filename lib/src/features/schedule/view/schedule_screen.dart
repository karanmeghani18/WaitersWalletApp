import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:waiters_wallet/src/features/schedule/controller/schedule_controller.dart';
import 'package:waiters_wallet/src/features/schedule/models/schedule_model.dart';
import 'package:waiters_wallet/src/widgets/week_dates_selector.dart';
import '../../../utils/utils.dart';
import '../widgets/schedule_tile.dart';

class ScheduleScreen extends ConsumerStatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> {


  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final startDate = getFormattedDate(getWeekStartDate(today));
    final endDate = getFormattedDate(getWeekEndDate(today));
    final weekHeaderString = "$startDate - $endDate";
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SafeArea(
          child: WeekDateSelector(
            today: today,
            weekHeaderString: weekHeaderString,
            onLeftArrowPress: () {
              setState(() {
                today = today.subtract(const Duration(days: 7));
              });
            },
            onRightArrowPress: () {
              setState(() {
                today = today.add(const Duration(days: 7));
              });
            },
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(scheduleControllerProvider);
            final schedule = state.schedule;
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final startingDate = getWeekStartDate(today);
                final DateTime currentDate =
                    startingDate.add(Duration(days: index));
                final String dateString = getScheduleFormattedDate(currentDate);
                List<ScheduleModel> result = [];

                for (var s in schedule) {
                  if (s.startOfShift.withoutTime == currentDate.withoutTime) {
                    result.add(s);
                  }
                }
                return Column(
                  children: [
                    ScheduleTile(
                      dateString: dateString,
                      currentDate: currentDate,
                      scheduleModel: result,
                    ),
                  ],
                );
              },
              itemCount: 7,
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  String getScheduleFormattedDate(DateTime date) {
    DateFormat formatter = DateFormat('EEEE, MMMM d');
    return formatter.format(date);
  }
}
