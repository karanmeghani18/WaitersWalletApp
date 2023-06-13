import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    required this.controller,
    required this.errorText,
  });

  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 42,
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 2),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                obscureText: isPassword,
                cursorHeight: 18,
                controller: controller,
                cursorColor: Colors.black,
                style: const TextStyle(
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 20, bottom: 12),
          child: Visibility(
            visible: errorText != "",
            child: Text(
              errorText,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
