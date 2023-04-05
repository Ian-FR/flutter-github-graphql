import '../entities/user_repository.dart';

extension UserRepositoryGithubGqlParser on UserRepository {
  static UserRepository fromMap(Map map) {
    return UserRepository(name: map['name']);
  }
}
