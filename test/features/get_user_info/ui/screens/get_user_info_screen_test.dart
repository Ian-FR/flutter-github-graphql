import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:github_graphql_api/features/get_user_info/ui/screens/get_user_info_screen.dart';
import 'package:github_graphql_api/shared/storage/shared_prefs_storage.dart';

import '../../../../helpers/extensions/widget_tester_extensions.dart';

class MockLocalStorage extends Mock implements LocalStorage {}

void main() {
  final mockStorage = MockLocalStorage();

  setUp(() {
    reset(mockStorage);
  });

  group('GetUserInfoScreen >', () {
    testWidgets('Render screen correctly', (tester) async {
      await tester.basePump(GetUserInfoScreen(localStorage: mockStorage));
      expect(find.byType(TextFormField), findsOneWidget);
    });
  });
}
