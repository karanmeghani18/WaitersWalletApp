import 'package:calendar_view/calendar_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiters_wallet/src/features/authentication/repository/auth_repo.dart';
import 'package:waiters_wallet/src/features/calendar/controller/calendar_event_controller.dart';
import 'package:waiters_wallet/src/features/restaurants/addrestaurant/repository/addrestaurant_repo.dart';
import 'package:waiters_wallet/src/features/schedule/controller/schedule_controller.dart';

import '../../../routing/routing.dart';
import '../../addtip/models/restaurant_model.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 1),
      () async {
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          await ref.read(authRepoProvider).fetchUser(currentUser.email!);
          await ref
              .read(calendarEventControllerProvider.notifier)
              .fetchTipsFromServer();
          await ref
              .read(scheduleControllerProvider.notifier)
              .fetchScheduleFromServer();
          await ref
              .read(addRestaurantRepoProvider)
              .fetchRestaurant()
              .then((value) {
            for (RestaurantModel element in value) {
              ref.read(authRepoProvider).addRestaurant(element);
            }
          });
          Navigator.pushReplacementNamed(
            context,
            Routing.homeScreen,
          );
        } else {
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
    ref.listen(calendarEventControllerProvider, (previous, next) {
      if (next.status == CalendarEventStatus.fetchingEventsSuccess) {
        for (var event in next.calendarEvents) {
          CalendarControllerProvider.of(context).controller.add(event);
        }
      }
    });
    ref.listen(scheduleControllerProvider, (previous, next) {});
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
