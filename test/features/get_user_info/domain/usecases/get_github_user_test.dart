import 'package:flutter_test/flutter_test.dart';
import 'package:github_graphql_api/features/get_user_info/domain/entities/user.dart';
import 'package:github_graphql_api/features/get_user_info/domain/errors/get_user_error.dart';
import 'package:github_graphql_api/features/get_user_info/domain/usecases/get_github_user.dart';
import 'package:graphql/client.dart';
import 'package:mocktail/mocktail.dart';

class MockGraphQLClient extends Mock implements GraphQLClient {}

class FakeQueryResult extends Mock implements QueryResult {}

class FakeQueryOptions extends Fake implements QueryOptions {}

void main() {
  final mockGraphQL = MockGraphQLClient();
  final fakeQueryResult = FakeQueryResult();

  final sut = GetGithubUser(gqlClient: mockGraphQL);

  setUp(() {
    reset(mockGraphQL);
    registerFallbackValue(FakeQueryResult());
    registerFallbackValue(FakeQueryOptions());
  });

  testWidgets('Perform correct query on fetch girhub user', (tester) async {
    const fakeData = {
      'user': {
        'avatarUrl': 'http://foo.com',
        'bio': 'Some biographic information',
        'repositories': {
          'nodes': [
            {'name': 'Repository Name'},
          ]
        }
      },
    };
    when(() => fakeQueryResult.data).thenReturn(fakeData);
    when((() => mockGraphQL.query(any())))
        .thenAnswer((_) async => fakeQueryResult);

    const tLogin = 'testLogin';
    final result = await sut.call(tLogin);

    expect(result, isA<User>());

    final options = verify(() => mockGraphQL.query(captureAny())).captured.first
        as QueryOptions;

    const query = '''
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

    expect(options.document, gql(query));
    expect(
      options.variables,
      {
        'login': tLogin,
        'nRepositories': 100,
      },
    );
  });

  testWidgets('Throws correct error when received null data', (tester) async {
    when(() => fakeQueryResult.data).thenReturn(null);
    when((() => mockGraphQL.query(any())))
        .thenAnswer((_) async => fakeQueryResult);

    late Object error;

    try {
      await sut.call('test');
    } catch (err) {
      error = err;
    }

    expect(error, GetUserError.fetchingUser);
  });

  testWidgets('Rethrows when graphQL throws', (tester) async {
    final expectError = Exception('Some Error');
    when((() => mockGraphQL.query(any()))).thenThrow(expectError);

    late Object error;

    try {
      await sut.call('test');
    } catch (err) {
      error = err;
    }

    expect(error, expectError);
  });
}
