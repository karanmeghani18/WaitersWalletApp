import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:waiters_wallet/src/features/addrestaurant/controller/addrestaurant_controller.dart';
import 'package:waiters_wallet/src/features/addtip/models/restaurant_model.dart';

import '../../../widgets/custom_auth_button.dart';
import '../../../widgets/custom_textfield.dart';

class AddRestaurantScreen extends ConsumerWidget {
  const AddRestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController restaurantNameController =
    TextEditingController();
    final TextEditingController barTipController = TextEditingController();
    final TextEditingController bohTipController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            const Text(
              "Add a Restaurant",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: "Restaurant Name",
              controller: restaurantNameController,
              errorText: "",
              kbType: TextInputType.text,
            ),
            CustomTextField(
              hintText: "Bar Tip out percentage",
              controller: barTipController,
              errorText: "",
              kbType: TextInputType.number,
            ),
            CustomTextField(
              hintText: "Back of the House Tip out Percentage",
              controller: bohTipController,
              errorText: "",
              kbType: TextInputType.number,
            ),
            const Spacer(),
            CustomAuthButton(
                text: "ADD",
                onPress: () {
                  final restaurantModel = RestaurantModel(
                    restaurantName: restaurantNameController.text,
                    barTipOut: double.parse(barTipController.text),
                    bohTipOut: double.parse(bohTipController.text),
                    id: const Uuid().v4(),
                  );
                  ref.read(addRestaurantControllerProvider.notifier)
                      .addRestaurant(restaurantModel: restaurantModel);
                  // ref
                  //     .read(calendarEventControllerProvider.notifier)
                  //     .addCalendarEvent(tipModel: tipModel);
                  // Navigator.of(context).pop();
                }),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
