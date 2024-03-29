import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiters_wallet/src/features/authentication/repository/auth_repo.dart';
import 'package:waiters_wallet/src/features/calendar/controller/calendar_event_controller.dart';
import 'package:waiters_wallet/src/routing/routing.dart';
import 'package:waiters_wallet/src/widgets/widgets.dart';

class AccountsScreen extends ConsumerStatefulWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends ConsumerState<AccountsScreen> {
  void logoutUser() async {
    await FirebaseAuth.instance.signOut().then((_) {
      Navigator.of(context).pushReplacementNamed(Routing.onBoardingScreen);
    });
    ref.read(calendarEventControllerProvider.notifier).removeAllEvents();
    ref.read(authRepoProvider).removeUser();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(calendarEventControllerProvider, (previous, next) {});
    final user = ref.read(authRepoProvider).getUser();
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20),
              child: Row(
                children: [
                  Text(
                    "Hello ${user.fullName}!",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomAuthButton(text: "Change Password", onPress: () {}),
          const SizedBox(height: 12),
          CustomAuthButton(text: "Edit Profile", onPress: () {}),
          const SizedBox(height: 12),
          CustomAuthButton(
              text: "Add Restaurant",
              onPress: () {
                Navigator.of(context).pushNamed(Routing.addRestaurant);
              }),
          const SizedBox(height: 12),
          const Spacer(),
          CustomAuthButton(
            text: "Logout",
            onPress: logoutUser,
            isRed: true,
          ),
          const Padding(padding: EdgeInsets.only(bottom: 14)),
        ],
      ),
    );
  }
}
