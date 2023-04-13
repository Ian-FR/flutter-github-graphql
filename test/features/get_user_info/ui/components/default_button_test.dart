import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:github_graphql_api/features/get_user_info/ui/components/default_button.dart';

import '../../../../helpers/extensions/widget_tester_extensions.dart';
import '../../../../helpers/handlers/tap_handler.dart';

void main() {
  final mockTap = MockTapHandler();
  group('DefaultButton >', () {
    testWidgets('Render DefaultButton correctly', (tester) async {
      const tLabel = 'Button Label';
      await tester.basePump(const DefaultButton(label: tLabel));
      expect(find.text(tLabel), findsOneWidget);
    });
    testWidgets('Calls onTap when button trigger a tap event', (tester) async {
      when(mockTap.onPressed).thenReturn(null);
      const tLabel = 'Button Label';
      await tester.basePump(DefaultButton(
        label: tLabel,
        onTap: mockTap.onPressed,
      ));
      await tester.tap(find.text(tLabel));
      verify(mockTap.onPressed).called(1);
    });
  });
}
