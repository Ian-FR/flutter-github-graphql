import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_graphql_api/features/get_user_info/domain/usecases/get_github_user.dart';

import '../../domain/entities/user.dart';
import '../../domain/errors/get_user_error.dart';

part 'user_state.dart';

class UserController extends Cubit<UserState> {
  UserController(this._fetchUser) : super(const LoadingUser());

  final GetGithubUser _fetchUser;

  Future<void> fetchUser(String username) async {
    try {
      final user = await _fetchUser.call(username);
      Future.delayed(const Duration(milliseconds: 800));
      emit(LoadedUser(user: user));
    } catch (err, st) {
      debugPrint(
        'Error on Fetch github user: \n  $err  \n\n With stackTrace: \n  $st',
      );
      emit(
        ErrorLoadingUser(
          err is GetUserError ? err : GetUserError.unexpected,
        ),
      );
    }
  }
}
