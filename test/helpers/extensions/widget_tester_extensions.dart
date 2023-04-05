import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterExtensions on WidgetTester {
  Future<void> basePump(Widget widget,
      {Map<String, Widget Function()>? routes}) async {
    final testRoutes = {
      '/': (_) => Material(child: widget),
      ...routes?.map<String, Widget Function(BuildContext)>(
              (key, value) => MapEntry(key, (_) => value.call())) ??
          {},
    };
    await pumpWidget(MaterialApp(routes: testRoutes));
  }
}
