import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomErrorDialog extends StatelessWidget {
  const CustomErrorDialog({
    super.key,
    required this.errorMessage,
    required this.errorTitle,
  });

  final String errorMessage;
  final String errorTitle;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(errorTitle),
      content: Text(errorMessage),
      actions: [
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "OK",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
