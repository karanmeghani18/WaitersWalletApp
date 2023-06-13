import 'package:firebase_auth/firebase_auth.dart';
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

        final currentUser = FirebaseAuth.instance.currentUser;
        if(currentUser!=null){
          Navigator.pushReplacementNamed(
            context,
            Routing.homeScreen,
          );
        }else{
          Navigator.pushReplacementNamed(
            context,
            Routing.onBoardingScreen,
          );
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
