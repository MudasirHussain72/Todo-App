import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/component/round_button.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view_model/controller/forgot_password/forgot_password_controller.dart';

class ForgotPasswordButtonWidget extends StatelessWidget {
  final bool selected;
  const ForgotPasswordButtonWidget({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: selected
          ? MediaQuery.of(context).size.height * .40
          : MediaQuery.of(context).size.height / .5,
      right: 20,
      left: 20,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
      child: Consumer<ForgotPasswordController>(
          builder: (context, provider, child) {
        return RoundButton(
          title: 'Continue',
          loading: provider.loading,
          onPress: () {
            if (provider.forgotPasswordEmailController.text.isEmpty) {
              Utils.flushBarErrorMessage('Enter email', context);
            } else {
              provider.forgotPassword(context);
            }
          },
          borderRadius: 12,
        );
      }),
    );
  }
}
