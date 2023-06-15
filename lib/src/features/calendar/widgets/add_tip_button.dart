import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:waiters_wallet/src/constants/color_constants.dart';
import 'package:waiters_wallet/src/features/addtip/views/addtip_screen.dart';

class AddTipButton extends StatelessWidget {
  const AddTipButton({
    super.key,
    required this.selectedDate,
  });

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        showBarModalBottomSheet(
          context: context,
          builder: (context) => AddTipSheet(dateTime: selectedDate),
        );
      },
      backgroundColor: skinColorConst,
      icon: const Icon(Icons.add),
      label: const Text(
        'Add',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
