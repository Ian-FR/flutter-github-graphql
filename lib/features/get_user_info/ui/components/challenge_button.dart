import 'package:flutter/material.dart';

class ChallangeButton extends StatelessWidget {
  const ChallangeButton({
    super.key,
    required this.label,
    this.onTap,
  });

  final VoidCallback? onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(label),
    );
  }
}
