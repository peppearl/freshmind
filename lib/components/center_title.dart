import 'package:flutter/material.dart';

class CenterTitle extends StatelessWidget {
  const CenterTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          height: 2,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          shadows: [Shadow(color: Color(0xFF899393), offset: Offset(0, -5))],
          color: Colors.transparent,
          decoration: TextDecoration.underline,
          decorationColor: Color(0xFF73BBB3),
          decorationThickness: 2,
          decorationStyle: TextDecorationStyle.solid,
        ),
      ),
    );
  }
}
