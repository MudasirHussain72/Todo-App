import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/component/input_text_field.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view_model/controller/signup/signup_controller.dart';

class SignupNameInputTextFiled extends StatelessWidget {
  const SignupNameInputTextFiled({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupController>(builder: (context, provider, child) {
      return InputTextField(
        myController: provider.nameController,
        focusNode: provider.nameFocusNode,
        onFiledSubmittedValue: (newValue) {
          Utils.fieldFocus(
              context, provider.nameFocusNode, provider.emailFocusNode);
        },
        keyBoardType: TextInputType.name,
        hint: 'Enter your name',
        onValidator: (value) {
          return null;
        },
      );
    });
  }
}
