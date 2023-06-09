import 'package:flutter/material.dart';
import 'package:waiters_wallet/src/constants/color_constants.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key,
    required this.text,
    required this.onPress,
  });

  final String text;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        height: 48,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        color: skinColorConst,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}