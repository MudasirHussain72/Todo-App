import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/component/input_text_field.dart';
import 'package:todo_app/view_model/controller/forgot_password/forgot_password_controller.dart';

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
    return Consumer<ForgotPasswordController>(
        builder: (context, provider, child) {
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
