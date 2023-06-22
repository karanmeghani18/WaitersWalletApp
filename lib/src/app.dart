import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiters_wallet/src/features/calendar/controller/calendar_event_controller.dart';
import 'package:waiters_wallet/src/routing/routing.dart';

class WaitersWalletApp extends ConsumerWidget {
  const WaitersWalletApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(calendarEventControllerProvider, (previous, next) {});
    return CalendarControllerProvider(
      controller: ref
          .read(calendarEventControllerProvider.notifier)
          .eventController,
      child: MaterialApp(
        title: 'Waiters Wallet',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: 'Lato',
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routing.onGenerateRoute,
      ),
    );
  }
}
