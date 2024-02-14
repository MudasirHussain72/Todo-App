import 'package:flutter/material.dart';
import 'package:todo_app/utils/routes/route_name.dart';
import 'package:todo_app/view/dashboard/dashboard_view.dart';
import 'package:todo_app/view/forgot_password/forgot_password_view.dart';
import 'package:todo_app/view/login/login_view.dart';
import 'package:todo_app/view/signup/signup_view.dart';
import 'package:todo_app/view/splash_view/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.splashView:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case RouteName.loginView:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case RouteName.signUpView:
        return MaterialPageRoute(builder: (_) => SignupView());
      case RouteName.forgotView:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case RouteName.dashboardView:
        return MaterialPageRoute(builder: (_) => DashboardView());
      // case RouteName.profileScreen:
      //   return MaterialPageRoute(
      //       builder: (_) => ProfileScreen(
      //             data: arguments as Map,
      //           ));

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
