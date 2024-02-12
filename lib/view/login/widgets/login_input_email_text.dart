import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/component/input_text_field.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view_model/controller/login/login_controller.dart';

class LoginEmailInputTextFiled extends StatelessWidget {
  const LoginEmailInputTextFiled({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(builder: (context, provider, child) {
      return InputTextField(
        myController: provider.emailController,
        focusNode: provider.emailFocusNode,
        onFiledSubmittedValue: (newValue) {
          Utils.fieldFocus(
              context, provider.emailFocusNode, provider.passwordFocusNode);
        },
        keyBoardType: TextInputType.emailAddress,
        hint: 'Enter your e-mail',
        onValidator: (value) {
          return null;
        },
      );
    });
  }
}
