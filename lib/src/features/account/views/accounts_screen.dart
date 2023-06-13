import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waiters_wallet/src/routing/routing.dart';
import 'package:waiters_wallet/src/widgets/widgets.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  void logoutUser() async {
    await FirebaseAuth.instance.signOut().then((_) {
        Navigator.of(context).pushReplacementNamed(Routing.onBoardingScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          CustomAuthButton(text: "Logout", onPress: logoutUser),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
        ],
      ),
    );
  }
}
