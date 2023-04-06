import 'package:flutter/material.dart';
import 'package:github_graphql_api/shared/graph_ql/graph_ql.dart';
import 'package:github_graphql_api/shared/storage/shared_prefs_storage.dart';

import 'core/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await localStorage.init();
  await graphQL.init();

  runApp(const MyApp());
}
