import 'package:github_graphql_api/core/env.dart';

class AppConstants {
  const AppConstants._();
  static const appTitle = 'App titlte';
  static const gitHubHostGrapQL = 'https://api.github.com/graphql';
  static final gitHubPersonalToken = Env.githubPersonalToken;
}
