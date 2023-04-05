import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onboarding_challenge/features/get_user_info/ui/components/challenge_button.dart';

import '../../../../helpers/extensions/widget_tester_extensions.dart';
import '../../../../helpers/handlers/tap_handler.dart';

void main() {
  final mockTap = MockTapHandler();
  group('ChallangeButton >', () {
    testWidgets('Render ChallangeButton correctly', (tester) async {
      const tLabel = 'Button Label';
      await tester.basePump(const ChallangeButton(label: tLabel));
      expect(find.text(tLabel), findsOneWidget);
    });
    testWidgets('Calls onTap when button trigger a tap event', (tester) async {
      when(mockTap.onPressed).thenReturn(null);
      const tLabel = 'Button Label';
      await tester.basePump(ChallangeButton(
        label: tLabel,
        onTap: mockTap.onPressed,
      ));
      await tester.tap(find.text(tLabel));
      verify(mockTap.onPressed).called(1);
    });
  });
}
