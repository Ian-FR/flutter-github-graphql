import 'package:flutter/material.dart';

class ChallangeButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;

  const ChallangeButton({super.key, required this.onTap, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onTap, child: Text(label));
  }
}
