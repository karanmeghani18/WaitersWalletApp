import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:waiters_wallet/src/features/schedule/models/schedule_model.dart';

import '../../../constants/color_constants.dart';
import '../view/add_schedule.dart';

class ScheduleTile extends StatelessWidget {
  const ScheduleTile({
    Key? key,
    required this.dateString,
    required this.currentDate,
    this.scheduleModel,
  }) : super(key: key);

  final String dateString;
  final DateTime currentDate;
  final List<ScheduleModel>? scheduleModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
        right: 10,
        left: 10,
      ),
      decoration: BoxDecoration(
        color: skinColorConst.withOpacity(0.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateString,
                  style: const TextStyle(fontSize: 18),
                ),
                IconButton(
                  onPressed: () {
                    showBarModalBottomSheet(
                      context: context,
                      builder: (context) =>
                          AddScheduleScreen(selectedDate: currentDate),
                    );
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          if (scheduleModel != null)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: scheduleModel!.length,
              itemBuilder: (context, index) {
                final schedule = scheduleModel![index];
                final startTimeString =
                    "${schedule.startOfShift.hour}:${schedule.startOfShift.minute}";
                final endTimeString =
                    "${schedule.endOfShift.hour}:${schedule.endOfShift.minute}";
                final shiftString =
                    "${schedule.restaurantName} - $startTimeString to $endTimeString";
                return GestureDetector(
                   onTap: () {
                     print(schedule.restaurantName);
                   },
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          shiftString,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
