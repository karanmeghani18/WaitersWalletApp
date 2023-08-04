import 'dart:io';

import 'package:calendar_view/calendar_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waiters_wallet/src/features/authentication/controller/auth_controller.dart';
import 'package:waiters_wallet/src/features/authentication/repository/auth_repo.dart';
import 'package:waiters_wallet/src/features/calendar/controller/calendar_event_controller.dart';
import 'package:waiters_wallet/src/features/goals/controller/goals_controller.dart';
import 'package:waiters_wallet/src/features/restaurants/addrestaurant/repository/addrestaurant_repo.dart';
import 'package:waiters_wallet/src/features/schedule/controller/schedule_controller.dart';

import '../../../constants/string_const.dart';
import '../../../routing/routing.dart';
import '../../addtip/models/restaurant_model.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  Future<void> performAppInitialization(
      BuildContext context, bool isLoggedIn, bool hasEnabledBiometric) async {

  }

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 1),
      () async {
        // Obtain shared preferences.
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final bool isLoggedIn = prefs.getBool(isLoginKey) ?? false;
        final bool hasEnabledBiometric = prefs.getBool(isBiometricEnabled) ?? false;
        if (isLoggedIn) {
          if (hasEnabledBiometric) {
            final authenticate = await ref
                .read(authControllerProvider.notifier)
                .authenticateWithBiometrics();
            if (!authenticate) exit(0);
          }

          final currentUserEmail = FirebaseAuth.instance.currentUser!.email!;
          await ref.read(authRepoProvider).fetchUser(currentUserEmail);
          await ref
              .read(calendarEventControllerProvider.notifier)
              .fetchTipsFromServer();
          await ref
              .read(scheduleControllerProvider.notifier)
              .fetchScheduleFromServer();

          final restaurantList =
          await ref.read(addRestaurantRepoProvider).fetchRestaurant();
          for (RestaurantModel element in restaurantList) {
            ref.read(authRepoProvider).addRestaurant(element);
          }
          Navigator.pushReplacementNamed(context, Routing.homeScreen);
        } else {
          Navigator.pushReplacementNamed(context, Routing.onBoardingScreen);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(calendarEventControllerProvider, (previous, next) {
      if (next.status == CalendarEventStatus.fetchingEventsSuccess) {
        for (var event in next.calendarEvents) {
          CalendarControllerProvider.of(context).controller.add(event);
        }
      }
    });
    ref.listen(scheduleControllerProvider, (previous, next) {});
    ref.listen(goalsControllerProvider, (previous, next) {});
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
