import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_graphql_api/core/routes.dart';
import 'package:github_graphql_api/features/get_user_info/ui/components/challenge_button.dart';
import 'package:github_graphql_api/shared/strings/strings.dart';
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

      expect(
        find.text(strings.getUserInfoForm.getUserInputLabel),
        findsOneWidget,
      );
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(DefaultButton), findsOneWidget);
      expect(
        find.text(strings.getUserInfoForm.getUserInfoButtonLabel),
        findsOneWidget,
      );
    });
    testWidgets('Calls getSring on screens init', (tester) async {
      const savedLogin = 'foo';
      when(() => mockStorage.getString(LocalStorageKeys.userLoginStorageKey))
          .thenReturn(savedLogin);

      await tester.basePump(GetUserInfoScreen(localStorage: mockStorage));

      verify(() => mockStorage.getString(LocalStorageKeys.userLoginStorageKey))
          .called(1);
      expect(find.text(savedLogin), findsOneWidget);
    });
    testWidgets(
        'Calls setSring and navigates to second screen when DefaultButton is triggered',
        (tester) async {
      const tipedLogin = 'foo';
      when(() => mockStorage.setString(
              LocalStorageKeys.userLoginStorageKey, tipedLogin))
          .thenAnswer((_) async => {});

      await tester.basePump(GetUserInfoScreen(localStorage: mockStorage),
          routes: {Routes.userDetails: () => const DummyScreen()});
      await tester.enterText(find.byType(TextFormField), tipedLogin);

      expect(find.text(tipedLogin), findsOneWidget);

      await tester.tap(find.byType(DefaultButton));

      verify(() => mockStorage.setString(
          LocalStorageKeys.userLoginStorageKey, tipedLogin)).called(1);

      await tester.pumpAndSettle();

      expect(find.text('Dummy Screen'), findsOneWidget);
    });
  });
}

class DummyScreen extends StatelessWidget {
  const DummyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Dummy Screen'),
    );
  }
}
