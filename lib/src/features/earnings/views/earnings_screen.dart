import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiters_wallet/src/features/earnings/widgets/earings_chart.dart';
import 'package:waiters_wallet/src/features/earnings/widgets/period_slider.dart';

class EarningsScreen extends ConsumerStatefulWidget {
  const EarningsScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _EarningsScreenState();
}

class _EarningsScreenState extends ConsumerState<EarningsScreen> {
  int groupValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 24, bottom: 10),
            child: Text(
              "Earnings",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        EarningsChart(
          chartLevel: groupValue,

        ),
        PeriodSlider(
          onValueChanged: (value) {
            setState(() {
              groupValue = value!;
            });
          },
        ),
      ],
    );
  }
}
