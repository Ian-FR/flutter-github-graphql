import 'package:flutter/material.dart';
import 'package:onboarding_challenge/shared/graph_ql/graph_ql.dart';
import 'package:onboarding_challenge/shared/storage/shared_prefs_storage.dart';

import 'core/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await localStorage.init();
  await graphQL.init();

  runApp(const MyApp());
}
