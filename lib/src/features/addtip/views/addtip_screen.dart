import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:waiters_wallet/src/constants/color_constants.dart';
import 'package:waiters_wallet/src/widgets/custom_auth_button.dart';
import 'package:waiters_wallet/src/widgets/custom_textfield.dart';

class AddTipSheet extends StatelessWidget {
  const AddTipSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            CustomAuthButton(text: "ADD", onPress: () {
              Navigator.of(context).pop();
              Fluttertoast.showToast(
                msg: "Tip Added",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: skinColorConst,
                textColor: Colors.black,
                fontSize: 16.0,
              );
            }),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
