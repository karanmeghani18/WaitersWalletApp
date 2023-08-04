import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waiters_wallet/src/features/authentication/repository/auth_repo.dart';
import 'package:waiters_wallet/src/features/calendar/controller/calendar_event_controller.dart';
import 'package:waiters_wallet/src/routing/routing.dart';
import 'package:waiters_wallet/src/widgets/widgets.dart';

import '../../../constants/string_const.dart';
import '../../authentication/controller/auth_controller.dart';

class AccountsScreen extends ConsumerStatefulWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends ConsumerState<AccountsScreen> {
  bool faceIdEnabled = false;

  Future initialiseFaceId() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      faceIdEnabled = prefs.getBool(isBiometricEnabled) ?? false;
    });

  }

  @override
  void initState(){
    super.initState();
    initialiseFaceId();
  }

  void logoutUser() async {
    await FirebaseAuth.instance.signOut().then((_) {
      Navigator.of(context).pushReplacementNamed(Routing.onBoardingScreen);
    });
    ref.read(calendarEventControllerProvider.notifier).removeAllEvents();
    ref.read(authRepoProvider).removeUser();
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isLoginKey, false);
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
          CustomAuthButton(
              text: "Change Password",
              onPress: () async {
                var errorText = await ref
                    .read(authRepoProvider)
                    .sendPasswordResetEmail(user.email);
                Fluttertoast.showToast(msg: errorText);
              }),
          const SizedBox(height: 12),
          CustomAuthButton(
              text: "Manage Restaurants",
              onPress: () {
                Navigator.of(context).pushNamed(Routing.manageRestaurant);
              }),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("FaceID For Login"),
              Switch.adaptive(
                value: faceIdEnabled,
                onChanged: (isEnabled) async {
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  setState(() {
                    faceIdEnabled = isEnabled;
                  });
                  prefs.setBool(isBiometricEnabled, isEnabled);
                  if (isEnabled) {
                    await ref
                        .read(authControllerProvider.notifier)
                        .authenticateWithBiometrics();
                  }
                },
              ),
            ],
          ),
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
