import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:waiters_wallet/src/constants/color_constants.dart';
import 'package:waiters_wallet/src/features/addtip/models/tip_model.dart';
import 'package:waiters_wallet/src/features/calendar/controller/calendar_event_controller.dart';
import 'package:waiters_wallet/src/features/restaurants/addrestaurant/controller/addrestaurant_controller.dart';
import 'package:waiters_wallet/src/widgets/widgets.dart';

import '../models/restaurant_model.dart';

class AddTipSheet extends ConsumerStatefulWidget {
  const AddTipSheet({
    Key? key,
    required this.dateTime,
  }) : super(key: key);

  final DateTime dateTime;

  @override
  ConsumerState<AddTipSheet> createState() => _AddTipSheetState();
}

class _AddTipSheetState extends ConsumerState<AddTipSheet> {
  final TextEditingController tipAmountController = TextEditingController();
  final TextEditingController hoursController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  String? selectedItem = "";
  List<RestaurantModel> restaurants = [];

  @override
  void initState() {

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    restaurants =
        ref.watch(addRestaurantControllerProvider.notifier).getRestaurants();
    selectedItem = restaurants.first.restaurantName;
  }

  @override
  Widget build(BuildContext context) {
    restaurants =
        ref.watch(addRestaurantControllerProvider.notifier).getRestaurants();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            const Text(
              "Add Tip",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: "Tip Amount",
              controller: tipAmountController,
              errorText: "",
              kbType: TextInputType.number,
            ),
            CustomTextField(
              hintText: "Hours Worked",
              controller: hoursController,
              errorText: "",
              kbType: TextInputType.number,
            ),
            CustomTextField(
              hintText: "Notes",
              controller: notesController,
              errorText: "",
            ),
            SizedBox(
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
            const Spacer(),
            CustomAuthButton(
                text: "ADD",
                onPress: () {
                  print(selectedItem);
                  final tipModel = TipModel(
                    fullDateTime: widget.dateTime,
                    tipAmount: double.parse(tipAmountController.text),
                    hoursWorked: double.parse(hoursController.text),
                    restaurantId: restaurants
                        .firstWhere(
                            (element) => element.restaurantName == selectedItem)
                        .id,
                    notes: notesController.text,
                    id: const Uuid().v4(),
                  );
                  ref
                      .read(calendarEventControllerProvider.notifier)
                      .addCalendarEvent(tipModel: tipModel);
                  Navigator.of(context).pop();
                }),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
