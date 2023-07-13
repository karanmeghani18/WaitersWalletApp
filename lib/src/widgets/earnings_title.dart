import 'package:flutter/cupertino.dart';

class EarningsTile extends StatelessWidget {
  const EarningsTile({
    super.key,
    required this.hours,
    required this.takeHome,
  });

  final double takeHome;
  final double hours;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Column(
            children: [
              const Text(
                "Take Home",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "\$$takeHome",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        const SizedBox(width: 40),
        Flexible(
          child: Column(
            children: [
              const Text(
                "Hours",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "$hours hrs",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        const SizedBox(width: 40),
        Flexible(
          child: Column(
            children: [
              const Text(
                "Avg. Hourly",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "\$${takeHome != 0 ? (takeHome / hours).toStringAsFixed(2) : 0.0}",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}