import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class InputFieldIcon extends StatelessWidget {
  final String title;
  final String hint;
  final String fieldName;
  final Color textColor;
  final Color iconColor;
  final TextEditingController? controller;
  final Widget? widget;
  final String? Function(String?)? validator;

  const InputFieldIcon(
      {super.key,
      required this.title,
      required this.hint,
      required this.fieldName,
      required this.textColor,
      required this.iconColor,
      this.controller,
      this.validator,
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
          FormBuilderTextField(
            name: fieldName,
            validator: validator,
            controller: controller,
            cursorColor: const Color(0xFF8B8B8B),
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              icon: Icon(
                Icons.person_add_outlined,
                color: iconColor,
              ),
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
