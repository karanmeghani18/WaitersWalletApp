import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiters_wallet/src/features/earnings/widgets/earings_chart.dart';

class EarningsScreen extends ConsumerStatefulWidget {
  const EarningsScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _EarningsScreenState();
}

class _EarningsScreenState extends ConsumerState<EarningsScreen> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 14, bottom: 20),
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
        EarningsChart(),
      ],
    );
  }
}
