import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_graphql_api/features/get_user_info/domain/errors/get_user_error.dart';
import 'package:github_graphql_api/features/get_user_info/domain/usecases/get_github_user.dart';
import 'package:github_graphql_api/features/get_user_info/ui/controllers/user_controller.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/user_fixture.dart';

class MockGetGithubUser extends Mock implements GetGithubUser {}

void main() {
  final mockfetchUser = MockGetGithubUser();
  final userController = UserController(mockfetchUser);
  final tUser = UserFixture.full;

  setUp(() {
    reset(mockfetchUser);
  });

  blocTest<UserController, UserState>(
    'Emits correct states when fetchUser is triggered',
    build: () => userController,
    setUp: () {
      when(() => mockfetchUser.call('testUser')).thenAnswer((_) async => tUser);
    },
    act: (bloc) => bloc.fetchUser('testUser'),
    expect: () => [
      const LoadingUser(),
      LoadedUser(user: tUser),
    ],
  );
  blocTest<UserController, UserState>(
    'Emits correct error state when fetchUser fails with unmapped error',
    build: () => userController,
    setUp: () {
      when(() => mockfetchUser.call('testUser')).thenThrow(Exception());
    },
    act: (bloc) => bloc.fetchUser('testUser'),
    skip: 1,
    expect: () => [const ErrorLoadingUser(GetUserError.unexpected)],
  );
}
