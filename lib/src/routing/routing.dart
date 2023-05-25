import 'package:flutter/material.dart';
import 'package:waiters_wallet/src/features/authentication/authentication.dart';
import 'package:waiters_wallet/src/features/onboarding/views/onboarding_screen.dart';

import '../features/splash/splash.dart' show SplashScreen;

class Routing {
  static const String splashScreen = '/';
  static const String loginScreen = '/login';
  static const String signupScreen = '/signup';
  static const String resetPasswordScreen = '/resetPassword';
  static const String onBoardingScreen = '/onBoarding';
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
          builder: (context) => const OnboardingScreen(),
          settings: const RouteSettings(
            name: onBoardingScreen,
          ),
        );
      case loginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
          settings: const RouteSettings(
            name: loginScreen,
          ),
        );
      case signupScreen:
        return MaterialPageRoute(
          builder: (context) => const SignupScreen(),
          settings: const RouteSettings(
            name: signupScreen,
          ),
        );
      case resetPasswordScreen:
        return MaterialPageRoute(
          builder: (context) => const ResetPasswordScreen(),
          settings: const RouteSettings(
            name: resetPasswordScreen,
          ),
        );
      default:
        throw Exception('Unknown route: ${settings.name}');
    }
  }
}
