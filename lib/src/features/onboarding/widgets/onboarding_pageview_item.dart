import 'package:flutter/material.dart';

class OnboardingPageViewItem extends StatelessWidget {
  const OnboardingPageViewItem({
    Key? key,
    required this.iconLocation,
    required this.title,
    required this.subtitle,
    this.isAppLogo = false
  }) : super(key: key);

  final String iconLocation;
  final String title;
  final String subtitle;
  final bool isAppLogo;

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}
