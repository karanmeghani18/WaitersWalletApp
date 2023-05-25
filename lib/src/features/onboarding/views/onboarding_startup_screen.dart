import 'package:flutter/material.dart';

class OnboardingStartUpScreen extends StatelessWidget {
  const OnboardingStartUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SafeArea(
              child: Image.asset(
                "assets/images/logo.png",
                height: 220,
                width: 220,
              ),
            ),
            const Text(
              "Waiter’s Wallet",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Elevating your serving game, one tip at a time!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            // const SignUpButton(
            //   logoSvg: "assets/icons/google.svg",
            //   methodName: "Google",
            // ),
            // const SizedBox(height: 18),
            // const SignUpButton(
            //   logoSvg: "assets/icons/mail.svg",
            //   methodName: "Email",
            // ),
            Spacer(),
            Text("Already have an account? Login."),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                "By continuing you are agreeing to our Terms and Privacy Policy.",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
