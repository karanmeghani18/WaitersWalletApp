import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:waiters_wallet/src/constants/color_constants.dart';
import 'package:waiters_wallet/src/features/calendar/controller/calendar_event_controller.dart';
import 'package:waiters_wallet/src/widgets/custom_auth_button.dart';
import 'package:waiters_wallet/src/widgets/custom_textfield.dart';

class AddTipSheet extends ConsumerWidget {
  const AddTipSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              controller: TextEditingController(),
              errorText: "",
            ),
            CustomTextField(
              hintText: "Hours Worked",
              controller: TextEditingController(),
              errorText: "",
            ),
            CustomTextField(
              hintText: "Notes",
              controller: TextEditingController(),
              errorText: "",
            ),
            const Spacer(),
            CustomAuthButton(
                text: "ADD",
                onPress: () {
                  ref
                      .read(calendarEventControllerProvider.notifier)
                      .addCalendarEvent(
                        dateTime: DateTime.now(),
                        eventName: 'Event 1',
                      );

                  Navigator.of(context).pop();
                }),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
