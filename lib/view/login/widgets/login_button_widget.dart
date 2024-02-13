import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/component/round_button.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view_model/controller/login/login_controller.dart';

class LoginButtonWidget extends StatelessWidget {
  final bool selected;
  const LoginButtonWidget({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(builder: (context, provider, child) {
      return AnimatedPositioned(
          top: selected
              ? MediaQuery.of(context).size.height * .46
              : MediaQuery.of(context).size.height / .5,
          right: 20,
          left: 20,
          duration: const Duration(seconds: 2),
          curve: Curves.fastOutSlowIn,
          child: SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * .9,
            child: RoundButton(
              title: 'Login',
              loading: provider.loading,
              onPress: () {
                if (provider.emailController.text.isEmpty) {
                  Utils.flushBarErrorMessage('Enter email', context);
                } else if (provider.passwordController.text.isEmpty) {
                  Utils.flushBarErrorMessage('Enter password', context);
                } else if (!Utils().emailValidator(
                    provider.emailController.text.trim().toString())) {
                  Utils.flushBarErrorMessage('Email is not valid', context);
                } else if (provider.passwordController.text.length < 6) {
                  Utils.flushBarErrorMessage(
                      'Password must be at least 6 character', context);
                } else {
                  provider.login(context);
                }
              },
              borderRadius: 12,
            ),
          ));
    });
  }
}
