class Env {
  const Env._();
  static String get githubPersonalToken => const String.fromEnvironment('GITHUB_TOKEN');
}
