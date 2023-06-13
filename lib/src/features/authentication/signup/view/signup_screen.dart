import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:waiters_wallet/src/validators/validators.dart';
import 'package:waiters_wallet/src/widgets/CustomErrorDialog.dart';
import 'package:waiters_wallet/src/widgets/widgets.dart';

import '../../../../routing/routing.dart';
import '../../../home/views/home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool rememberMe = false;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String emailErrorText = "";
  String passwordErrorText = "";
  String nameErrorText = "";

  void signUserUp() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((value) {
        if (value.user != null) {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return const HomeScreen();
          }), (route) => false);
        }
      });
    } on FirebaseAuthException catch (e) {
      showCupertinoDialog(
          context: context,
          builder: (context) {
            String errorMessage = "";
            if (e.code == 'weak-password') {
              errorMessage = 'The password provided is too weak.';
            } else if (e.code == 'email-already-in-use') {
              errorMessage = 'The account already exists for that email.';
            }
            return CustomErrorDialog(
              errorMessage: errorMessage,
              errorTitle: "Signup Error",
            );
          });
    }
  }

  void validateCredentials() {
    final String emailText = emailController.text;
    final String passwordText = passwordController.text;
    final String nameText = nameController.text;
    setState(() {
      emailErrorText = validateEmail(emailText) ?? "";
      passwordErrorText = validatePassword(passwordText) ?? "";
      nameErrorText = validateFullName(nameText) ?? "";
    });
    if (validateEmail(emailText) == null &&
        validatePassword(passwordText) == null) {
      signUserUp();
    }
  }

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
            CustomTextField(
              hintText: "Full Name",
              controller: nameController,
              errorText: nameErrorText,
            ),
            CustomTextField(
              hintText: "Email",
              controller: emailController,
              errorText: emailErrorText,
            ),
            CustomTextField(
              hintText: "Password",
              isPassword: true,
              controller: passwordController,
              errorText: passwordErrorText,
            ),
            const Spacer(),
            CustomAuthButton(text: "SIGNUP", onPress: validateCredentials),
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
