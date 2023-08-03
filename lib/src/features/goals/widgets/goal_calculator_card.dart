import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class GoalCalculatorCard extends StatefulWidget {
  const GoalCalculatorCard({
    super.key,
    required this.takeHome,
    required this.hours,
    required this.averageHourly,
    required this.isWeekly,
  });

  final double takeHome;
  final double hours;
  final double averageHourly;
  final bool isWeekly;

  @override
  State<GoalCalculatorCard> createState() => _GoalCalculatorCardState();
}

class _GoalCalculatorCardState extends State<GoalCalculatorCard> {
  int selectedTerm = 0;
  double termMultiplier = 1.0;
  bool isWeek = false;

  @override
  void initState() {
    super.initState();
    isWeek = widget.isWeekly;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isWeekly != isWeek) {
      print("change");
      isWeek = widget.isWeekly;
      setState(() {
        if (selectedTerm == 0) {
          termMultiplier = isWeek ? 1.0 : 0.25;
        } else if (selectedTerm == 1) {
          termMultiplier = isWeek ? 4.0 : 1.0;
        } else {
          termMultiplier = isWeek ? 52.0 : 12.0;
        }

      });
    }
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTerm = 0;
                        termMultiplier = widget.isWeekly ? 1.0 : 0.25;
                      });
                    },
                    child: TermContainer(
                      title: "Weekly",
                      isSelected: selectedTerm == 0,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTerm = 1;
                        termMultiplier = widget.isWeekly ? 4.0 : 1.0;
                      });
                    },
                    child: TermContainer(
                      title: "Monthly",
                      isSelected: selectedTerm == 1,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTerm = 2;
                        termMultiplier = widget.isWeekly ? 52.0 : 12.0;
                      });
                    },
                    child: TermContainer(
                      title: "Yearly",
                      isSelected: selectedTerm == 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          CalculatorTile(
            title: "Take Home",
            amount: widget.takeHome * termMultiplier,
          ),
          CalculatorTile(
            title: "Hours",
            amount: widget.hours * termMultiplier,
          ),
          CalculatorTile(
            title: "Average Hourly",
            amount: widget.takeHome / widget.hours,
          ),
        ],
      ),
    );
  }
}

class CalculatorTile extends StatelessWidget {
  const CalculatorTile({
    super.key,
    required this.amount,
    required this.title,
  });

  final double amount;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "\$$amount",
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class TermContainer extends StatelessWidget {
  const TermContainer({
    super.key,
    required this.title,
    required this.isSelected,
  });

  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: isSelected ? skinColorConst : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black)
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
