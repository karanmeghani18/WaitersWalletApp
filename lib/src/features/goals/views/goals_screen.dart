import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';
import 'package:waiters_wallet/src/constants/color_constants.dart';
import 'package:waiters_wallet/src/features/goals/widgets/goals_charts.dart';

import '../../addtip/models/tip_model.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  @override
  Widget build(BuildContext context) {
    List<TipModel> dailyData =
        generateRandomData(30); // Generate 30 random daily data
    List<TipModel> weeklyData =
        generateRandomData(30); // Generate 7 random weekly data
    List<TipModel> monthlyData =
        generateRandomData(30); // Generate 12 random monthly data
    List<TipModel> yearlyData =
        generateRandomData(30); // Generate 3 random yearly data

    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.add, size: 28)),
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
          children: [
            GoalsPieChart(title: 'Daily', tipData: dailyData), // Daily
            GoalsPieChart(title: 'Weekly', tipData: weeklyData), // Weekly
            GoalsPieChart(title: 'Monthly', tipData: monthlyData), // Monthly
            GoalsPieChart(title: 'Yearly', tipData: yearlyData), // Yearly
          ],
        ),
      ),
    );
  }

  List<TipModel> generateRandomData(int count) {
    final faker = Faker.instance;

    return List.generate(count, (index) {
      final fullDateTime = faker.datatype.dateTime(min: 2022, max: 2023);
      final tipAmount = faker.datatype.float(min: 50, max: 200);
      final hoursWorked = faker.datatype.float(min: 2, max: 8);
      final restaurantId = faker.datatype.uuid();
      final notes = faker.lorem.sentence();
      final id = faker.datatype.uuid();
      final salesAmount = faker.datatype.float(min: 1000, max: 3500);
      final takeHome = faker.datatype.float(min: 60, max: 300);
      final barTipOutAmount = faker.datatype.float(min: 10, max: 90);
      final bohTipOutAmount = faker.datatype.float(min: 10, max: 90);

      return TipModel(
        fullDateTime: fullDateTime,
        tipAmount: tipAmount,
        hoursWorked: hoursWorked,
        restaurantId: restaurantId,
        notes: notes,
        id: id,
        salesAmount: salesAmount,
        takeHome: takeHome,
        barTipOutAmount: barTipOutAmount,
        bohTipOutAmount: bohTipOutAmount,
      );
    });
  }
}
