import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:waiters_wallet/src/widgets/widgets.dart';

import '../../../../routing/routing.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool rememberMe = false;

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
                "Sign Up",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const CustomTextField(hintText: "Full Name"),
            const CustomTextField(hintText: "Email"),
            const CustomTextField(
              hintText: "Password",
              isPassword: true,
            ),
            const Spacer(),
            const CustomAuthButton(text: "SIGNUP"),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xff959595),
                    ),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacementNamed(
                          context,
                          Routing.loginScreen,
                        );
                      },
                    text: "Login",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xff07F8DB),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
