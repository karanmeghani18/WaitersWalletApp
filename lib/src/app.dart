import 'package:flutter/material.dart';
import 'package:waiters_wallet/src/routing/routing.dart';

class WaitersWalletApp extends StatelessWidget {
  const WaitersWalletApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waiters Wallet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Lato'
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routing.onGenerateRoute,
    );
  }
}
