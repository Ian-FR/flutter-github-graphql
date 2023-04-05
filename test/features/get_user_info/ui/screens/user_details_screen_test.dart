import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:onboarding_challenge/features/get_user_info/domain/errors/get_user_error.dart';
import 'package:onboarding_challenge/features/get_user_info/ui/components/get_user_error_component.dart';
import 'package:onboarding_challenge/features/get_user_info/ui/components/user_details_component.dart';
import 'package:onboarding_challenge/features/get_user_info/ui/controllers/user_controller.dart';
import 'package:onboarding_challenge/features/get_user_info/ui/screens/user_details_screen.dart';

import '../../../../helpers/extensions/widget_tester_extensions.dart';
import '../../fixtures/user_fixture.dart';

class MockUserController extends Mock implements UserController {
  @override
  Future<void> close() async {}
}

void main() {
  late MockUserController mockUserController;

  setUp(() {
    mockUserController = MockUserController();
  });

  group('UserDetailsScreen >', () {
    const tLogin = 'username';
    setUp(() {
      when((() => mockUserController.fetchUser(tLogin))).thenAnswer(
        (_) async => LoadedUser(user: UserFixture.full),
      );
    });
    testWidgets('Render circular loading when state is LoadingUser',
        (tester) async {
      whenListen(
        mockUserController,
        Stream.value(const LoadingUser()),
        initialState: const LoadingUser(),
      );
      await tester.basePump(UserDetailsScreen(
        githubLogin: tLogin,
        userController: mockUserController,
      ));
      expect(find.byType(UserDetailsContent), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(UserDetailsComponent), findsNothing);
      expect(find.byType(GetUserErrorComponent), findsNothing);
    });
    testWidgets('Render UserDetailsComponent when state is LoadedUser',
        (tester) async {
      whenListen(
        mockUserController,
        Stream.value(LoadedUser(user: UserFixture.full)),
        initialState: const LoadingUser(),
      );
      await mockNetworkImages(() async {
        await tester.basePump(UserDetailsScreen(
          githubLogin: tLogin,
          userController: mockUserController,
        ));
        await tester.pumpAndSettle();
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.byType(UserDetailsComponent), findsOneWidget);
        expect(find.byType(GetUserErrorComponent), findsNothing);
      });
    });
    testWidgets('Render GetUserErrorComponent when state is ErrorLoadingUser',
        (tester) async {
      whenListen(
        mockUserController,
        Stream.value(const ErrorLoadingUser(GetUserError.fetchingUser)),
        initialState: const LoadingUser(),
      );
      await tester.basePump(UserDetailsScreen(
        githubLogin: tLogin,
        userController: mockUserController,
      ));
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(UserDetailsComponent), findsNothing);
      expect(find.byType(GetUserErrorComponent), findsOneWidget);
    });
    testWidgets('CALLS fetchUser on screen init', (tester) async {
      whenListen(
        mockUserController,
        Stream.value(const LoadingUser()),
        initialState: const LoadingUser(),
      );
      await tester.basePump(UserDetailsScreen(
        githubLogin: tLogin,
        userController: mockUserController,
      ));
      verify((() => mockUserController.fetchUser(tLogin))).called(1);
    });
  });
}
