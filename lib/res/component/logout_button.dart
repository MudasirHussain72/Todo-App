import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:todo_app/res/component/round_button.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view/login/login_view.dart';
import 'package:todo_app/view_model/services/session_controller.dart';
import 'package:todo_app/view_model/services/user_preference.dart';

class LogoutButtonWidget extends StatelessWidget {
  const LogoutButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 31, vertical: 20),
      child: RoundButton(
          title: 'Logout',
          onPress: () {
            FirebaseAuth.instance.signOut().then((value) {
              UserPreferences().removeUser().then((newValue) {
                UserPreferences().getUser().then((value) {
                  SessionController().isLogin = false;
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const LoginView(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                });
              });
            }).onError((error, stackTrace) {
              Utils.flushBarErrorMessage(
                  'Something went wrong, please try again later.', context);
            });
          }),
    );
  }
}
