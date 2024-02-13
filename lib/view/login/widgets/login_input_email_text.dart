import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/component/input_text_field.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view_model/controller/login/login_controller.dart';

class LoginEmailInputTextFiled extends StatelessWidget {
  final bool selected;
  const LoginEmailInputTextFiled({Key? key, required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: selected
          ? MediaQuery.of(context).size.height * .26
          : MediaQuery.of(context).size.height / .7,
      right: 20,
      left: 20,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
      child: Consumer<LoginController>(builder: (context, provider, child) {
        return SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: InputTextField(
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
          ),
        );
      }),
    );
  }
}
