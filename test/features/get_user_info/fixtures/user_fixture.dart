import 'package:onboarding_challenge/features/get_user_info/domain/entities/user.dart';
import 'package:onboarding_challenge/features/get_user_info/domain/entities/user_repository.dart';

class UserFixture {
  static User get full => const User(
        avatarUrl: 'test',
        bio: 'bio test',
        repositories: [
          UserRepository(name: 'repo test 1'),
          UserRepository(name: 'repo test 2'),
          UserRepository(name: 'repo test 3'),
        ],
      );

  static User get empty => const User(repositories: []);
}
