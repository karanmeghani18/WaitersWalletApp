import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:waiters_wallet/src/constants/color_constants.dart';
import 'package:waiters_wallet/src/features/account/views/accounts_screen.dart';
import 'package:waiters_wallet/src/features/calendar/views/calendar_screen.dart';
import 'package:waiters_wallet/src/features/earnings/views/earnings_screen.dart';
import 'package:waiters_wallet/src/features/goals/views/goals_screen.dart';

import '../../calendar/controller/calendar_event_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static const List<Widget> _widgetOptions = <Widget>[
    CalendarScreen(),
    EarningsScreen(),
    GoalsScreen(),
    Center(
      child: Text(
        'Index 3: Schedule',
        style: optionStyle,
      ),
    ),
    AccountsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(calendarEventControllerProvider, (previous, next) {
      if (next.status == CalendarEventStatus.addEvent) {
        final event = next.events.last;

        CalendarControllerProvider.of(context).controller.add(event);

        Fluttertoast.showToast(
          msg: "Tip Added",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: skinColorConst,
          textColor: Colors.black,
          fontSize: 16.0,
        );
      }
    });

    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph),
            label: 'Earnings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.area_chart),
            label: 'Goals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: skinColorConst,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.black.withOpacity(0.7),
        iconSize: 25,
      ),
    );
  }
}
