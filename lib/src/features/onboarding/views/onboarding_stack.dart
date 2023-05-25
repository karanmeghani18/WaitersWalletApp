import 'package:flutter/material.dart';
import 'package:waiters_wallet/src/features/onboarding/widgets/onboarding_pageview_item.dart';

class MainOnboardingScreen extends StatefulWidget {
  const MainOnboardingScreen({Key? key}) : super(key: key);

  @override
  State<MainOnboardingScreen> createState() => _MainOnboardingScreenState();
}

class _MainOnboardingScreenState extends State<MainOnboardingScreen> {
  final PageController _pageController = PageController();
  //this local variable will be changed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 470,
            child: PageView.builder(
              itemBuilder: (context, index) => OnboardingPageViewItem(
                iconLocation: "assets/images/logo.png",
                title: "Waiter’s Wallet",
                subtitle: "Elevating your serving game, one tip at a time!",
                isAppLogo: true,
              ),
            ),
          ),
        ],
      ),
    );
    //   Scaffold(
    //   body: Stack(
    //     alignment: Alignment.center,
    //     children: [
    //       PageView(
    //         controller: _pageController,
    //         children: const [
    //           OnboardingStartUpScreen(),
    //           OnboardingStartUpScreen(),
    //           OnboardingStartUpScreen(),
    //         ],
    //       ),
    //       const Positioned(
    //         height: 106,
    //         top: 470,
    //         child: Column(
    //           children: [
    //             SignUpButton(
    //               logoSvg: "assets/icons/google.svg",
    //               methodName: "Google",
    //             ),
    //             SizedBox(height: 18),
    //             SignUpButton(
    //               logoSvg: "assets/icons/mail.svg",
    //               methodName: "Email",
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
