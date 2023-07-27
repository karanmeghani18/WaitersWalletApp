import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:waiters_wallet/src/constants/color_constants.dart';
import 'package:waiters_wallet/src/features/authentication/models/wallet_user.dart';
import 'package:waiters_wallet/src/features/authentication/repository/auth_repo.dart';
import 'package:waiters_wallet/src/features/goals/controller/goals_controller.dart';
import 'package:waiters_wallet/src/features/goals/views/add_goals_screen.dart';
import 'package:waiters_wallet/src/features/goals/widgets/goal_tracker_widget.dart';

class GoalsScreen extends ConsumerStatefulWidget {
  const GoalsScreen({super.key});

  @override
  ConsumerState<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends ConsumerState<GoalsScreen> {
  late WalletUser user;

  @override
  void initState() {
    super.initState();
    user = ref.read(authRepoProvider).getUser();
    if (user.goals != null) {
      print(user.goals?.hoursGoal);
      ref
          .read(goalsControllerProvider.notifier)
          .setGoalsFromServer(user.goals!);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(goalsControllerProvider, (previous, next) {});
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
