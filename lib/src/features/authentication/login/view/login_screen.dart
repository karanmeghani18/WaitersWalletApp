import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:waiters_wallet/src/widgets/widgets.dart';

import '../../../../routing/routing.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ).then((value) => print(value.user));
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
            ),
            CustomTextField(
              hintText: "Password",
              isPassword: true,
              controller: passwordController,
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
                              return const Color(0xffDAA98A).withOpacity(.32);
                            }
                            return const Color(0xffDAA98A);
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
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Color(0xffDAA98A),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            CustomAuthButton(text: "LOGIN", onPress: signUserIn),
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
