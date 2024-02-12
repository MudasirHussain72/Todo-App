import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/res/component/input_text_field_with_suffix_icon_widget.dart';
import 'package:todo_app/view_model/controller/signup/signup_controller.dart';

class SignupPasswordInputTextFiled extends StatelessWidget {
  const SignupPasswordInputTextFiled({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupController>(
        builder: (context, provider, child) =>
            InputTextFieldWidgetWithSuffixIcon(
              myController: provider.passwordController,
              focusNode: provider.passwordFocusNode,
              obscureText: provider.showPassword,
              keyBoardType: TextInputType.text,
              hint: 'Enter your password',
              onFiledSubmittedValue: (newValue) {},
              onValidator: (value) {
                return null;
              },
              suffixWidget: IconButton(
                  onPressed: () {
                    if (provider.showPassword) {
                      provider.setShowPassword(false);
                    } else {
                      provider.setShowPassword(true);
                    }
                  },
                  icon: Icon(
                    provider.showPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.primaryIconColor,
                  )),
            ));
  }
}
