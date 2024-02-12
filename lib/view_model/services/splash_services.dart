import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/utils/routes/route_name.dart';
import 'package:todo_app/view_model/services/session_controller.dart';

class SplashServices {
  Future isLogin(BuildContext? context) async {
    await SessionController.getUserFromPreference().then((userData) {
      print(SessionController().user.uid);
      if (SessionController().isLogin!) {
        Timer(
          const Duration(seconds: 2),
          () => Navigator.pushNamedAndRemoveUntil(
              context!, RouteName.dashboardView, (route) => false),
        );
      } else {
        Timer(
          const Duration(seconds: 2),
          () => Navigator.pushNamedAndRemoveUntil(
              context!, RouteName.loginView, (route) => false),
        );
      }
    });
  }
}
