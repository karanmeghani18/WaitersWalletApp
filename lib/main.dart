import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiters_wallet/src/api/notifications_api.dart';
import 'package:waiters_wallet/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationsApi.init(initScheduled: true);
  runApp(
    const ProviderScope(
      child: WaitersWalletApp(),
    ),
  );
}
