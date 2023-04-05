import 'user_repository.dart';

class User {
  final String? avatarUrl, bio;
  final List<UserRepository> repositories;

  const User({
    this.avatarUrl,
    this.bio,
    required this.repositories,
  });
}
