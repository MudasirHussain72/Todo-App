import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/component/input_text_field.dart';
import 'package:todo_app/view_model/controller/login/login_controller.dart';

class ForgotPasswordEmailInputTextFiled extends StatefulWidget {
  const ForgotPasswordEmailInputTextFiled({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordEmailInputTextFiled> createState() =>
      _ForgotPasswordEmailInputTextFiledState();
}

class _ForgotPasswordEmailInputTextFiledState
    extends State<ForgotPasswordEmailInputTextFiled> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(builder: (context, provider, child) {
      // return InputTextField(
      //   myController: provider.forgotPasswordEmailController,
      //   focusNode: provider.forgotPasswordEmailFocusNode,
      //   onFiledSubmittedValue: (newValue) {},
      //   keyBoardType: TextInputType.emailAddress,
      //   hint:
      //       '${AppLocalizations.of(context)!.enterYour} ${AppLocalizations.of(context)!.email}',
      //   onValidator: (value) {
      //     return null;
      //   },
      // );
      return InputTextField(
        myController: provider.forgotPasswordEmailController,
        focusNode: provider.forgotPasswordEmailFocusNode,
        onFiledSubmittedValue: (newValue) {},
        keyBoardType: TextInputType.emailAddress,
        hint: 'Enter your e-mail',
        onValidator: (value) {
          return null;
        },
      );
    });
  }
}
