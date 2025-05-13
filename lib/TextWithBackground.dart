import 'package:flutter/material.dart';

class TextWithBackground extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final List<BoxShadow>? boxShadow; // Ajout du paramètre boxShadow

  const TextWithBackground({
    super.key,
    required this.text,
    required this.backgroundColor,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0.0,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        boxShadow: boxShadow ?? [],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
      ),
    );
  }
}