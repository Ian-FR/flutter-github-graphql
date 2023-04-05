import 'package:flutter/material.dart';

class GetUserErrorComponent extends StatelessWidget {
  const GetUserErrorComponent({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}
