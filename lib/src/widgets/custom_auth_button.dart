import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key,
    required this.text,
    this.onPress,
  });

  final String text;
  final VoidCallbackAction? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress,
      child: Container(
        height: 48,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        color: const Color(0xffDAA98A),
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