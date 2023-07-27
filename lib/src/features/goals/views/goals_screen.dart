import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:waiters_wallet/src/constants/color_constants.dart';
import 'package:waiters_wallet/src/features/goals/views/add_goals_screen.dart';
import 'package:waiters_wallet/src/features/goals/widgets/goal_tracker_widget.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                showBarModalBottomSheet(
                  context: context,
                  builder: (context) => const AddGoalsScreen(),
                );
              },
              icon: const Icon(Icons.add, size: 28),
            ),
          ],
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Goals',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          bottom: TabBar(
            indicatorColor: skinColorConst,
            labelColor: skinColorConst,
            unselectedLabelColor: Colors.black,
            labelStyle: const TextStyle(fontSize: 14),
            tabs: const [
              Tab(text: 'Daily'),
              Tab(text: 'Weekly'),
              Tab(text: 'Monthly'),
              Tab(text: 'Yearly'),
            ],
          ),
        ),
        body: TabBarView(
          children: List.generate(
            4,
            (index) => GoalTracker(
              tabIndex: index,
            ),
          ),
        ),
      ),
    );
  }
}
