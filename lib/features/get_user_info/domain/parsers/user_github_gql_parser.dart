import '../entities/user.dart';
import 'user_repository_github_gql_parser.dart';

extension UserGithubGqlParser on User {
  static User fromMap(Map map) {
    return User(
      avatarUrl: map['user']['avatarUrl'],
      bio: map['user']['bio'],
      repositories: (map['user']['repositories']['nodes'] as List?)
              ?.map((e) => UserRepositoryGithubGqlParser.fromMap(e))
              .toList() ??
          [],
    );
  }
}
