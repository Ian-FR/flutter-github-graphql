import 'package:graphql/client.dart';
import 'package:github_graphql_api/shared/graph_ql/graph_ql.dart';

import '../parsers/user_github_gql_parser.dart';
import '../entities/user.dart';
import '../errors/get_user_error.dart';

class GetGithubUser {
  Future<User> call(String login) async {
    final result = await graphQL.client.value.query(
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
