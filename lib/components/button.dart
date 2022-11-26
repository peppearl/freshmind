import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button(
      {Key? key,
      required this.backgroundColor,
      required this.title,
      required this.elevation,
      required this.onPressed})
      : super(key: key);

  final Color backgroundColor;
  final String title;
  final double elevation;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: elevation,
        ),
        onPressed: onPressed,
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
