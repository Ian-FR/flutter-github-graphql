import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:github_graphql_api/core/constants.dart';
import 'package:github_graphql_api/core/router.dart';
import 'package:github_graphql_api/shared/graph_ql/graph_ql.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: graphQL.client,
      child: MaterialApp(
        title: AppConstants.appTitle,
        theme: ThemeData(primarySwatch: Colors.red),
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
