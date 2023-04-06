import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_graphql_api/features/get_user_info/ui/controllers/user_controller.dart';
import 'package:github_graphql_api/shared/strings/strings.dart';

import '../components/get_user_error_component.dart';
import '../components/user_details_component.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({
    super.key,
    required this.githubLogin,
    required this.userController,
  });

  @visibleForTesting
  final UserController userController;

  final String githubLogin;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => userController..fetchUser(githubLogin),
      child: const UserDetailsContent(),
    );
  }
}

class UserDetailsContent extends StatelessWidget {
  const UserDetailsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(strings.userDetailsScreen.title)),
      body: BlocBuilder<UserController, UserState>(builder: (context, state) {
        switch (state.runtimeType) {
          case LoadedUser:
            return UserDetailsComponent(user: (state as LoadedUser).user);
          case ErrorLoadingUser:
            return GetUserErrorComponent(
                message: strings.userDetailsScreen
                    .errorMessageByError((state as ErrorLoadingUser).error));
          case LoadingUser:
          default:
            return const Center(child: CircularProgressIndicator.adaptive());
        }
      }),
    );
  }
}
