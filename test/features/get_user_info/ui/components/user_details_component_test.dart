import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:onboarding_challenge/features/get_user_info/ui/components/user_details_component.dart';

import '../../../../helpers/extensions/widget_tester_extensions.dart';
import '../../fixtures/user_fixture.dart';

void main() {
  group('UserDetailsComponent >', () {
    testWidgets('Render correct user details', (tester) async {
      await mockNetworkImages(() async {
        final tUser = UserFixture.full;
        await tester.basePump(UserDetailsComponent(user: tUser));
        await tester.pumpAndSettle();
        expect(find.byType(UserDetailsComponent), findsOneWidget);
        expect(find.byType(CircleAvatar), findsOneWidget);
        expect(find.text(tUser.bio!), findsOneWidget);
        expect(
            find.textContaining(tUser.repositories.first.name), findsOneWidget);
      });
    });
    testWidgets('NOT Render CircleAvatar when avatarUrl is null',
        (tester) async {
      await mockNetworkImages(() async {
        final tUser = UserFixture.empty;
        await tester.basePump(UserDetailsComponent(user: tUser));
        await tester.pumpAndSettle();
        expect(find.byType(CircleAvatar), findsNothing);
      });
    });
    testWidgets('Render all repositories names when have more than one',
        (tester) async {
      await mockNetworkImages(() async {
        final tUser = UserFixture.full;
        await tester.basePump(UserDetailsComponent(user: tUser));
        for (final repo in tUser.repositories) {
          expect(find.textContaining(repo.name), findsOneWidget);
        }
      });
    });
  });
}
