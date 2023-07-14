import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:waiters_wallet/src/features/schedule/controller/schedule_controller.dart';
import 'package:waiters_wallet/src/features/schedule/models/schedule_model.dart';

import '../../../constants/color_constants.dart';
import '../../addtip/models/restaurant_model.dart';
import '../../restaurants/addrestaurant/controller/addrestaurant_controller.dart';

class AddScheduleScreen extends ConsumerStatefulWidget {
  const AddScheduleScreen({Key? key, required this.selectedDate})
      : super(key: key);

  final DateTime selectedDate;

  @override
  ConsumerState<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends ConsumerState<AddScheduleScreen> {
  DateTime startOfShift = DateTime.now();
  DateTime endOfShift = DateTime.now();
  String? selectedItem = "";
  List<RestaurantModel> restaurants = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    restaurants =
        ref.watch(addRestaurantControllerProvider.notifier).getRestaurants();
    selectedItem = restaurants.isEmpty ? "" : restaurants.first.restaurantName;
    startOfShift = widget.selectedDate;
    endOfShift = widget.selectedDate;
  }

  void showCustomTimePicker(bool isStartTime) {
    showCupertinoModalPopup<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => SizedBox(
        height: 256,
        child: CupertinoDatePicker(
          initialDateTime: DateTime.now(),
          mode: CupertinoDatePickerMode.time,
          use24hFormat: false,
          // This is called when the user changes the time.
          onDateTimeChanged: (DateTime newTime) {
            if (isStartTime) {
              startOfShift = newTime;
            } else {
              endOfShift = newTime;
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    restaurants =
        ref.watch(addRestaurantControllerProvider.notifier).getRestaurants();
    ref.listen(scheduleControllerProvider, (previous, next) {
      if (next.status == ScheduleStatus.addScheduleSuccess) {
        Navigator.of(context).pop();
      }
      if (next.status == ScheduleStatus.addScheduleFailure) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => CupertinoAlertDialog(
            title: const Text("Error Adding Schedule"),
            content: Text(next.message),
            actions: [
              GestureDetector(
                child: Text("OK"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
    });
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              "Add Shift For: ${getScheduleFormattedDate(widget.selectedDate)}"),
          Text("Shift Start Time"),
          ElevatedButton(
            onPressed: () {
              showCustomTimePicker(true);
            },
            child: Text('Select Time'),
          ),
          Text("Shift End Time"),
          ElevatedButton(
            onPressed: () {
              showCustomTimePicker(false);
            },
            child: Text('Select Time'),
          ),
          restaurants.isEmpty
              ? const SizedBox()
              : Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child: DropdownButtonFormField<String>(
                      padding: EdgeInsets.zero,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 3,
                            color: skinColorConst,
                          ),
                        ),
                      ),
                      value: selectedItem,
                      items: restaurants
                          .map((e) => DropdownMenuItem<String>(
                                value: e.restaurantName,
                                child: Text(e.restaurantName),
                              ))
                          .toList(),
                      onChanged: (selected) => setState(() {
                        selectedItem = selected;
                      }),
                    ),
                  ),
                ),
          ElevatedButton(
            onPressed: () async {
              final restaurantSelected = restaurants.firstWhere(
                (element) => element.restaurantName == selectedItem,
              );
              final scheduleModel = ScheduleModel(
                id: const Uuid().v4(),
                startOfShift: startOfShift,
                endOfShift: endOfShift,
                restaurantId: restaurantSelected.id,
                restaurantName: restaurantSelected.restaurantName,
              );
              await ref
                  .read(scheduleControllerProvider.notifier)
                  .addSchedule(scheduleModel);
            },
            child: Text('Add Schedule'),
          ),
        ],
      ),
    );
  }

  String getScheduleFormattedDate(DateTime date) {
    DateFormat formatter = DateFormat('EEEE, MMMM d');
    return formatter.format(date);
  }
}
