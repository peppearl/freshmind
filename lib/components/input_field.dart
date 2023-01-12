import 'package:flutter/material.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final Color textColor;
  final TextEditingController? controller;
  final Widget? widget;

  const MyInputField(
      {super.key,
      required this.title,
      required this.hint,
      required this.textColor,
      this.controller,
      this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: textColor),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controller,
            cursorColor: const Color(0xFF8B8B8B),
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: hint,
              labelStyle: const TextStyle(
                color: Color(0xFF8B8B8B),
              ),
              focusColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 0,
                  //style: BorderStyle.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
