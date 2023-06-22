import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'package:waiters_wallet/src/features/addtip/models/restaurant_model.dart';

import '../../../../constants/color_constants.dart';
import '../../../../widgets/custom_auth_button.dart';
import '../../../../widgets/custom_textfield.dart';
import '../controller/addrestaurant_controller.dart';

class AddRestaurantScreen extends ConsumerWidget {
  const AddRestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(addRestaurantControllerProvider, (previous, next) {
      if (next.status == AddRestaurantStatus.addingRestaurantSuccess) {
        Fluttertoast.showToast(
          msg: "Restaurant Added",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: skinColorConst,
          textColor: Colors.black,
          fontSize: 16.0,
        );
        Navigator.of(context).pop();
      }
    });
    final TextEditingController restaurantNameController =
        TextEditingController();
    final TextEditingController barTipController = TextEditingController();
    final TextEditingController bohTipController = TextEditingController();

    return Scaffold(
      body: Column(
        children: [
          const SafeArea(
            child: Text(
              "Add a Restaurant",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ),
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
                ref
                    .read(addRestaurantControllerProvider.notifier)
                    .addRestaurant(restaurantModel: restaurantModel);
                // ref
                //     .read(calendarEventControllerProvider.notifier)
                //     .addCalendarEvent(tipModel: tipModel);
                // Navigator.of(context).pop();
              }),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
