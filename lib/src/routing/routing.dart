import 'package:flutter/material.dart';
import 'package:waiters_wallet/src/features/onboarding/views/onboarding_stack.dart';

import '../features/splash/splash.dart' show SplashScreen;

class Routing {
  // static const String splashScreen = '/';
  static const String splashScreen = '/splash';
  static const String loginScreen = '/login';
  static const String onBoardingScreen = '/';
  // static const String onBoardingScreen = '/onBoarding';
  static const String homeScreen = '/home';

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: const RouteSettings(
            name: splashScreen,
          ),
        );
      case onBoardingScreen:
        return MaterialPageRoute(
          builder: (context) => const MainOnboardingScreen(),
          settings: const RouteSettings(
            name: onBoardingScreen,
          ),
        );
      default:
        throw Exception('Unknown route: ${settings.name}');
    }
  }
}
