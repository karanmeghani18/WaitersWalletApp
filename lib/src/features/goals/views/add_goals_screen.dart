import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:waiters_wallet/src/constants/color_constants.dart';
import 'package:waiters_wallet/src/features/goals/controller/goals_controller.dart';
import 'package:waiters_wallet/src/features/goals/models/goals_model.dart';
import 'package:waiters_wallet/src/widgets/custom_auth_button.dart';
import 'package:waiters_wallet/src/widgets/custom_textfield.dart';

import '../widgets/goal_calculator_card.dart';

class AddGoalsScreen extends ConsumerStatefulWidget {
  const AddGoalsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddGoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends ConsumerState<AddGoalsScreen> {
  final TextEditingController takeHomeController = TextEditingController();
  final TextEditingController hoursController = TextEditingController();
  final TextEditingController averageHourlyController = TextEditingController();
  List<GoalType> goalsType = GoalType.values;
  String selectedGoal = GoalType.values.first.name;

  @override
  Widget build(BuildContext context) {
    ref.listen(goalsControllerProvider, (previous, next) {
      if (next.status == GoalsStatus.addGoalsSuccess) {

        Navigator.of(context).pop();
      } else if (next.status == GoalsStatus.addGoalsFailure) {
        print("Adding goals failure");
      }
    });
    return LoadingOverlay(
      isLoading:
          ref.watch(goalsControllerProvider).status == GoalsStatus.addingGoals,
      child: Column(
        children: [
          const Text(
            "Set Goals",
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: [
                const Text("Goal Type", style: TextStyle(fontSize: 18)),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    padding: EdgeInsets.zero,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          width: 3,
                          color: skinColorConst,
                        ),
                      ),
                    ),
                    value: selectedGoal,
                    items: goalsType
                        .map((e) => DropdownMenuItem<String>(
                              value: e.name,
                              child: Text(e.name.toUpperCase()),
                            ))
                        .toList(),
                    onChanged: (selected) {
                      setState(() {
                        selectedGoal = selected!;
                      });
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          CustomTextField(
            hintText: "Take Home Goal",
            controller: takeHomeController,
            errorText: "",
            kbType: TextInputType.number,
            onValueChanged: () => setState(() {}),
          ),
          CustomTextField(
            hintText: "Hours Goal",
            controller: hoursController,
            errorText: "",
            kbType: TextInputType.number,
            onValueChanged: () => setState(() {}),
          ),
          CustomTextField(
            hintText: "Average Hourly Goal",
            controller: averageHourlyController,
            errorText: "",
            kbType: TextInputType.number,
            onValueChanged: () => setState(() {}),
          ),
          GoalCalculatorCard(
            averageHourly: double.tryParse(averageHourlyController.text) ?? 0.0,
            hours: double.tryParse(hoursController.text) ?? 0.0,
            takeHome: double.tryParse(takeHomeController.text) ?? 0.0,
            isWeekly: goalsType
                    .firstWhere((element) => element.name == selectedGoal)
                    .index ==
                0,
          ),
          const Spacer(),
          CustomAuthButton(
              text: "SAVE",
              onPress: () {
                ref.read(goalsControllerProvider.notifier).addGoals(
                      GoalsModel(
                        averageHourlyGoal:
                            double.tryParse(averageHourlyController.text) ??
                                0.0,
                        hoursGoal: double.tryParse(hoursController.text) ?? 0.0,
                        takeHomeGoal:
                            double.tryParse(takeHomeController.text) ?? 0.0,
                        goalType:
                            goalsType.firstWhere((e) => e.name == selectedGoal),
                      ),
                    );
              }),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
