import 'package:github_graphql_api/shared/graph_ql/graph_ql.dart';
import 'package:graphql/client.dart';

import '../parsers/user_github_gql_parser.dart';
import '../entities/user.dart';
import '../errors/get_user_error.dart';

class GetGithubUser {
  GetGithubUser({GraphQLClient? gqlClient})
      : _graphQL = gqlClient ?? graphQL.client.value;

  final GraphQLClient _graphQL;

  Future<User> call(String login) async {
    final result = await _graphQL.query(
      QueryOptions(
        document: gql(_fetchGithubUserQuery),
        variables: {
          'login': login,
          'nRepositories': 100,
        },
      ),
    );

    if (result.data == null) throw GetUserError.fetchingUser;

    return UserGithubGqlParser.fromMap(result.data as Map);
  }
}

const _fetchGithubUserQuery = '''
  query FetchUser(\$login: String!, \$nRepositories: Int!) {
    user(login: \$login) {
      avatarUrl
      bio
      repositories(first: \$nRepositories) {
        nodes {
          name
        }
      }
    }
  }
''';
