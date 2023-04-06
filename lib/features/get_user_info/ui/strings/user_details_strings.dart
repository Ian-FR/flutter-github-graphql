import 'package:github_graphql_api/features/get_user_info/domain/errors/get_user_error.dart';

class UserDetailsStrings {
  String get title => 'Details';
  String get repositoriesSubtitle => 'Repositories:';
  errorMessageByError(GetUserError error) {
    switch (error) {
      case GetUserError.fetchingUser:
        return 'Error loding user, try again later..';
      case GetUserError.unexpected:
        return 'An unexpected error occurred, try again later..';
    }
  }
}
