part of 'user_controller.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class LoadingUser extends UserState {
  const LoadingUser();
}

class LoadedUser extends UserState {
  const LoadedUser({required this.user});

  final User user;
}

class ErrorLoadingUser extends UserState {
  const ErrorLoadingUser(this.error);

  final GetUserError error;

}
