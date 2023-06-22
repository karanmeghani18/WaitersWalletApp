import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:waiters_wallet/src/features/authentication/signup/controller/signup_controller.dart';
import 'package:waiters_wallet/src/validators/validators.dart';
import 'package:waiters_wallet/src/widgets/custom_error_dialog.dart';
import 'package:waiters_wallet/src/widgets/widgets.dart';

import '../../../../routing/routing.dart';
import '../../../home/views/home_screen.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  bool rememberMe = false;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String emailErrorText = "";
  String passwordErrorText = "";
  String nameErrorText = "";

  void signUserUp() async {
    ref.read(signUpControllerProvider.notifier).signUp(
          fullName: nameController.text,
          email: emailController.text,
          password: passwordController.text,
        );
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
        validatePassword(passwordText) == null &&
        validateFullName(nameText) == null) {
      signUserUp();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(signUpControllerProvider, (previous, next) {
      if (next.status == SignUpStatus.signingUpUserSuccess) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return const HomeScreen();
        }), (route) => false);
      }

      if (next.status == SignUpStatus.signingUpUserFailure) {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            String errorMessage = next.errorText;
            return CustomErrorDialog(
              errorMessage: errorMessage,
              errorTitle: "Signup Error",
            );
          },
        );
      }
    });
    return Scaffold(
      body: LoadingOverlay(
        isLoading: ref.watch(signUpControllerProvider).status ==
            SignUpStatus.signingUpUser,
        opacity: 0.9,
        progressIndicator: Lottie.asset(
          "assets/lottie/loading_animation.json",
        ),
        child: Center(
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
      ),
    );
  }
}
