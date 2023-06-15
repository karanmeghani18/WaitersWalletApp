import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:waiters_wallet/src/constants/color_constants.dart';
import 'package:waiters_wallet/src/features/home/views/home_screen.dart';
import 'package:waiters_wallet/src/validators/validators.dart';
import 'package:waiters_wallet/src/widgets/custom_error_dialog.dart';
import 'package:waiters_wallet/src/widgets/widgets.dart';

import '../../../../routing/routing.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  final emailController = TextEditingController(text: "test1@gmail.com");
  final passwordController = TextEditingController(text: "12345678");
  String emailErrorText = "";
  String passwordErrorText = "";

  void signUserIn() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
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
            if (e.code == 'user-not-found') {
              errorMessage = 'No user found for that email.';
            } else if (e.code == 'wrong-password') {
              errorMessage = 'Wrong password provided for that user.';
            }
            return CustomErrorDialog(errorMessage: errorMessage, errorTitle: "Login Error",);
          });
    }
  }

  void validateCredentials() {
    final String emailText = emailController.text;
    final String passwordText = passwordController.text;
    setState(() {
      emailErrorText = validateEmail(emailText) ?? "";
      passwordErrorText = validatePassword(passwordText) ?? "";
    });
    if (validateEmail(emailText) == null &&
        validatePassword(passwordText) == null) {
      signUserIn();
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
                "Login",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
              ),
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
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 10,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 18,
                        width: 18,
                        child: Checkbox(
                          value: rememberMe,
                          // fillColor:  Color(0xff07F8DB),
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return skinColorConst.withOpacity(.32);
                            }
                            return skinColorConst;
                          }),
                          onChanged: (value) {
                            setState(() {
                              rememberMe = !rememberMe;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text("Remember Me"),
                    ],
                  ),
                  const SizedBox(height: 22),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routing.resetPasswordScreen,
                      );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: skinColorConst,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            CustomAuthButton(text: "LOGIN", onPress: validateCredentials),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Don't have an account? ",
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
                          Routing.signupScreen,
                        );
                      },
                    text: "Sign Up",
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