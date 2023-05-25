import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
    required this.logoSvg,
    required this.methodName,
    this.onPress
  });

  final String logoSvg;
  final String methodName;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 44),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              logoSvg,
              height: 18,
              width: 18,
            ),
            const SizedBox(width: 12),
            Text(
              "Sign Up with $methodName",
              style: const TextStyle(
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}