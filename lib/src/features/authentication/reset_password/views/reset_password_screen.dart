import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:waiters_wallet/src/features/authentication/repository/auth_repo.dart';
import 'package:waiters_wallet/src/widgets/widgets.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
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
            const Padding(
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
            CustomTextField(
              hintText: "Email",
              controller: emailController,
              errorText: "",
            ),
            const SizedBox(height: 40),
            const Spacer(),
            CustomAuthButton(text: "REQUEST RESET CODE", onPress: (
                ) async {
              var errorText = await ref.read(authRepoProvider).sendPasswordResetEmail(emailController.text);
              Fluttertoast.showToast(msg: errorText);
            }),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
