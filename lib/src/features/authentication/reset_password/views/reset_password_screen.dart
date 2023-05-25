import 'package:flutter/material.dart';
import 'package:waiters_wallet/src/widgets/widgets.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 48,
                bottom: 14,
              ),
              child: Text(
                "Reset Password",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 10,
              ),
              child: Text(
                "Enter your email address below to receive a 4 digit code to reset password.",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff787878),
                ),
              ),
            ),
            CustomTextField(hintText: "Email"),
            SizedBox(height: 40),
            Spacer(),
            CustomAuthButton(text: "REQUEST RESET CODE"),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}


