import 'package:flutter_test/flutter_test.dart';
import 'package:onboarding_challenge/features/get_user_info/ui/components/get_user_error_component.dart';

import '../../../../helpers/extensions/widget_tester_extensions.dart';

void main() {
  group('GetUserErrorComponent >', () {
    testWidgets('Render component correctly', (tester) async {
      const tMessage = 'test error message';
      await tester.basePump(const GetUserErrorComponent(message: tMessage));
      expect(find.text(tMessage), findsOneWidget);
    });
  });
}
