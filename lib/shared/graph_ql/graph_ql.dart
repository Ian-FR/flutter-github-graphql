import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:github_graphql_api/core/constants.dart';

class GraphQL {
  late ValueNotifier<GraphQLClient> client;

  init() async {
    await initHiveForFlutter();

    final httpLink = HttpLink(AppConstants.gitHubHostGrapQL);

    final authLink = AuthLink(getToken: () => 'Bearer ${AppConstants.gitHubPersonalToken}');

    final link = authLink.concat(httpLink);

    client = ValueNotifier(
      GraphQLClient(
        link: link,
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
  }
}

final graphQL = GraphQL();
