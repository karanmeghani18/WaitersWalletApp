import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:waiters_wallet/src/features/onboarding/models/OnboardingItemModel.dart';
import 'package:waiters_wallet/src/features/onboarding/widgets/onboarding_pageview_item.dart';

import '../../../routing/routing.dart';
import '../widgets/widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  //this local variable will be changed
  final List<OnboardingItemModel> _onboardingItems = [
    OnboardingItemModel(
      iconLocation: "assets/images/logo.png",
      title: "Waiter’s Wallet",
      subtitle: "Elevating your serving game, one tip at a time!",
      isAppLogo: true,
    ),
    OnboardingItemModel(
      iconLocation: "assets/icons/tips.png",
      title: "Effortless Tip Recording",
      subtitle:
          "Seamlessly record tips with a few taps, ensuring accurate tracking of your earnings and empowering you to maximize your income potential.",
    ),
    OnboardingItemModel(
      iconLocation: "assets/icons/law.png",
      title: "Intelligent Tipout Calculation",
      subtitle:
          "Experience the power of automatic tipout calculation that takes the guesswork out of sharing gratuities, ensuring fairness and streamlining your workflow.",
    ),
    OnboardingItemModel(
      iconLocation: "assets/icons/earning.png",
      title: "Real-time Earnings Insights",
      subtitle:
          "Stay on top of your earnings with a dynamic, real-time summary that reveals your total tips and estimated hourly earnings, empowering you to make data-driven decisions.",
    ),
    OnboardingItemModel(
      iconLocation: "assets/icons/restaurant.png",
      title: "Multi-Restaurant Mastery",
      subtitle:
          "Take control of your serving career by effortlessly managing profiles for multiple restaurants, customizing tipout percentages, and seamlessly transitioning between establishments.",
    ),
    OnboardingItemModel(
      iconLocation: "assets/icons/clock.png",
      title: "Comprehensive Shift History & Reporting",
      subtitle:
          "Unlock a treasure trove of insights with a comprehensive shift history, allowing you to review detailed totals, tipouts paid, and hourly earnings, while impressing your manager with professional email reports.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 502,
            child: PageView.builder(
              controller: _pageController,
              itemBuilder: (context, index) => OnboardingPageViewItem(
                onboardingItem: _onboardingItems[index],
              ),
              itemCount: 6,
            ),
          ),
          SignUpButton(
            logoSvg: "assets/icons/google.svg",
            methodName: "Google",
            onPress: () {
              Fluttertoast.showToast(
                  msg: "Google Signup not implemented",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            },
          ),
          const SizedBox(height: 18),
          SignUpButton(
            logoSvg: "assets/icons/mail.svg",
            methodName: "Email",
            onPress: () {
              Navigator.pushNamed(
                context,
                Routing.signupScreen,
              );
            },
          ),
          const Spacer(),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(
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
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              "By continuing you are agreeing to our Terms and Privacy Policy.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff969696),
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
    //   Scaffold(
  }
}
