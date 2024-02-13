import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/component/input_text_field.dart';
import 'package:todo_app/view_model/controller/forgot_password/forgot_password_controller.dart';

class ForgotPasswordEmailInputTextFiled extends StatelessWidget {
  final bool selected;
  const ForgotPasswordEmailInputTextFiled({Key? key, required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        top: selected
            ? MediaQuery.of(context).size.height * .32
            : MediaQuery.of(context).size.height / .7,
        right: 20,
        left: 20,
        duration: const Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
        child: Consumer<ForgotPasswordController>(
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
        }));
  }
}
