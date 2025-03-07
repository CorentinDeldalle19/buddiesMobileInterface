import 'package:flutter/material.dart';
import 'TextWithBackground.dart'; // Assurez-vous d'importer le fichier

class Buttons extends StatelessWidget {
  final List<Map<String, dynamic>> buttonProps;

  const Buttons({super.key, required this.buttonProps});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.start,
        children: buttonProps.map<Widget>((props) {
          return TextWithBackground(
            text: props['text'],
            backgroundColor: props['backgroundColor'],
            borderColor: props['borderColor'] ?? Colors.transparent,
            borderWidth: props['borderWidth'] ?? 0.0,
            boxShadow: props['boxShadow'] ?? [],
          );
        }).toList(),
      ),
    );
  }
}