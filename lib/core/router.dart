import 'package:flutter/material.dart';
import 'package:onboarding_challenge/core/routes.dart';
import 'package:onboarding_challenge/features/get_user_info/domain/usecases/get_github_user.dart';
import 'package:onboarding_challenge/features/get_user_info/ui/controllers/user_controller.dart';
import 'package:onboarding_challenge/features/get_user_info/ui/screens/get_user_info_screen.dart';
import 'package:onboarding_challenge/features/get_user_info/ui/screens/user_details_screen.dart';
import 'package:onboarding_challenge/features/splash/ui/screens/splash_screen.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.userInfo:
        return _buildPage(const GetUserInfoScreen());

      case Routes.userDetails:
        return _buildPage(
          UserDetailsScreen(
            githubLogin: settings.arguments as String,
            userController: UserController(GetGithubUser()),
          ),
        );

      case Routes.splash:
      default:
        return _buildPage(const SplashScreen());
    }
  }

  static pushNamed<T>(BuildContext context, String routeName, {T? arguments}) {
    Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  static void go<T>(BuildContext context, String routeName, {T? arguments}) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (_) => false,
      arguments: arguments,
    );
  }

  static void pop<T>(BuildContext context,
      {String? fallbackRouteName, T? result}) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context, result);
    } else if (fallbackRouteName is String) {
      go(context, fallbackRouteName);
    }
  }
}

Route _buildPage(Widget screen) {
  return PageRouteBuilder(
    pageBuilder: (context, __, ___) => GestureDetector(
      onTap: () {
        final node = FocusScope.of(context);
        if (!node.hasPrimaryFocus) node.unfocus();
      },
      child: screen,
    ),
    transitionsBuilder: (_, animation, __, child) {
      const begin = 0.1; //Offset(0.5, 2.0);
      const end = 1.0; //Offset.zero;
      const curve = Curves.fastOutSlowIn;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return FadeTransition(
        opacity: animation.drive(tween),
        child: child,
      );
    },
  );
}
