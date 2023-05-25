import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../routing/routing.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 1),
          () {
        // Navigator.pushReplacementNamed(
        //   context,
        //   Routing.onBoardingScreen,
        // );
            if (kDebugMode) {
              print("Onto next screen");
            }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Hero(
          tag: 'logo',
          child: Image.asset(
            'assets/images/logo.png',
          ),
        ),
      ),
    );
  }
}
