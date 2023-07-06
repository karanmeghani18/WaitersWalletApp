import 'package:flutter/material.dart';

import '../../../constants/color_constants.dart';

class TipTile extends StatelessWidget {
  const TipTile({
    super.key,
    required this.restaurantName,
    required this.hoursWorked,
    required this.tipAmount,
    required this.onDismiss,
    required this.confirmDismiss,
    required this.onTap,
  });

  final String restaurantName;
  final double hoursWorked;
  final double tipAmount;
  final VoidCallback onDismiss;
  final Future<bool> Function() confirmDismiss;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      confirmDismiss: (direction) async {
        return confirmDismiss();
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          onDismiss();
        }
      },
      direction: DismissDirection.endToStart,
      background: const Align(
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
          color: Colors.red,
          size: 40,
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: skinColorConst.withOpacity(0.7),
                  blurRadius: 0.6,
                  spreadRadius: 0.6,
                  offset: const Offset(1, 2),
                ),
              ]),
          child: Row(
            children: [
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on),
                    Text(
                      restaurantName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.hourglass_bottom_sharp),
                    Text(
                      "$hoursWorked Hours",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.monetization_on_rounded),
                    Text(
                      tipAmount.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
