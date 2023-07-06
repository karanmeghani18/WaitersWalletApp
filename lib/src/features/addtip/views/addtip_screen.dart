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
    this.tipModel,
  }) : super(key: key);

  final DateTime dateTime;
  final TipModel? tipModel;

  @override
  ConsumerState<AddTipSheet> createState() => _AddTipSheetState();
}

class _AddTipSheetState extends ConsumerState<AddTipSheet> {
  final TextEditingController tipAmountController = TextEditingController();
  final TextEditingController hoursController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  String? selectedItem = "";
  List<RestaurantModel> restaurants = [];
  TipModel? updatedTip;

  @override
  void initState() {
    super.initState();
    updatedTip = widget.tipModel;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    restaurants =
        ref.watch(addRestaurantControllerProvider.notifier).getRestaurants();
    if (widget.tipModel != null) {
      tipAmountController.text = widget.tipModel!.tipAmount.toString();
      hoursController.text = widget.tipModel!.hoursWorked.toString();
      notesController.text = widget.tipModel!.notes;
      selectedItem = restaurants
          .firstWhere((element) => element.id == widget.tipModel!.restaurantId)
          .restaurantName;
    } else {
      selectedItem =
          restaurants.isEmpty ? "" : restaurants.first.restaurantName;
    }
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
            Text(
              widget.tipModel == null ? "Add Tip" : "Edit Tip",
              style: const TextStyle(
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
            restaurants.isEmpty
                ? SizedBox()
                : SizedBox(
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
                text: widget.tipModel == null ? "ADD" : "SAVE",
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
                    id: widget.tipModel == null
                        ? const Uuid().v4()
                        : widget.tipModel!.id,
                  );
                  if (widget.tipModel == null) {
                    ref
                        .read(calendarEventControllerProvider.notifier)
                        .addCalendarEvent(tipModel: tipModel);
                  } else {
                    updatedTip = tipModel;
                    ref
                        .read(calendarEventControllerProvider.notifier)
                        .editCalendarEvent(tipModel: tipModel);
                  }
                  Navigator.of(context).pop();
                }),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
