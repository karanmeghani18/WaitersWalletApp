import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiters_wallet/src/features/calendar/controller/calendar_event_controller.dart';
import 'package:waiters_wallet/src/widgets/widgets.dart';


class AddTipSheet extends ConsumerWidget {
  const AddTipSheet({
    Key? key,
    required this.dateTime,
  }) : super(key: key);

  final DateTime dateTime;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController tipAmountController = TextEditingController();
    final TextEditingController hoursController = TextEditingController();
    final TextEditingController notesController = TextEditingController();
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
            const Spacer(),
            CustomAuthButton(
                text: "ADD",
                onPress: () {
                  ref
                      .read(calendarEventControllerProvider.notifier)
                      .addCalendarEvent(
                        dateTime: dateTime,
                        eventName: 'Tips',
                        title: tipAmountController.text,
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
