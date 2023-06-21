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
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
              child: Text(
            ref.read(authRepoProvider).getUser().fullName,
          )),
          const Spacer(),
          CustomAuthButton(text: "Logout", onPress: logoutUser),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
        ],
      ),
    );
  }
}
