import 'package:flutter/material.dart';
import 'package:waiters_wallet/src/features/onboarding/models/OnboardingItemModel.dart';

class OnboardingPageViewItem extends StatelessWidget {
  const OnboardingPageViewItem({Key? key, required this.onboardingItem})
      : super(key: key);

  final OnboardingItemModel onboardingItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          SafeArea(
            child: Hero(
              tag: onboardingItem.isAppLogo ? 'logo' : '',
              child: Image.asset(
                onboardingItem.iconLocation,
                height: onboardingItem.isAppLogo ? 220 : 120,
                width: onboardingItem.isAppLogo ? 220 : 120,
              ),
            ),
          ),
          Text(
            onboardingItem.title,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            onboardingItem.subtitle,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
