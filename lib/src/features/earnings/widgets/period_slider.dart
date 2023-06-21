import 'package:flutter/cupertino.dart';

class PeriodSlider extends StatefulWidget {
  const PeriodSlider({
    Key? key,
    required this.onValueChanged,
  }) : super(key: key);

  final Function(int?) onValueChanged;

  @override
  State<PeriodSlider> createState() => _PeriodSliderState();
}

class _PeriodSliderState extends State<PeriodSlider> {
  int? groupValue = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 68,
        child: CupertinoSlidingSegmentedControl<int>(
            padding: const EdgeInsets.all(8),
            groupValue: groupValue,
            children: const {
              0: Text("Weekly"),
              1: Text("Monthly"),
            },
            onValueChanged: (value) {
              setState(() {
                groupValue = value;
              });
              widget.onValueChanged(value);
            }),
      ),
    );
  }
}
