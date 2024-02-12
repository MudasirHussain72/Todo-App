import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/res/component/google_login_widget.dart';
import 'package:todo_app/res/component/round_button.dart';
import 'package:todo_app/res/extensions.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view/signup/widgets/signup_input_email_text.dart';
import 'package:todo_app/view/signup/widgets/signup_input_name_text.dart';
import 'package:todo_app/view/signup/widgets/signup_password_input_text_field.dart';
import 'package:todo_app/view_model/controller/signup/signup_controller.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                60.height,
                Text(
                  'Create an account',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontSize: 26),
                ),
                6.height,
                Text(
                  'Please enter your information and create your account',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 20),
                ),
                30.height,
                const SignupNameInputTextFiled(),
                6.height,
                const SignupEmailInputTextFiled(),
                6.height,
                const SignupPasswordInputTextFiled(),
                30.height,
                Consumer<SignupController>(builder: (context, provider, child) {
                  return RoundButton(
                    title: 'Login',
                    loading: provider.loading,
                    onPress: () {
                      if (provider.emailController.text.isEmpty) {
                        Utils.flushBarErrorMessage('Enter email', context);
                      } else if (provider.passwordController.text.isEmpty) {
                        Utils.flushBarErrorMessage('Enter password', context);
                      } else if (!Utils().emailValidator(
                          provider.emailController.text.trim().toString())) {
                        Utils.flushBarErrorMessage(
                            'Email is not valid', context);
                      } else if (provider.passwordController.text.length < 6) {
                        Utils.flushBarErrorMessage(
                            'Password must be at least 6 character', context);
                      } else {
                        provider.signup(context);
                      }
                    },
                    borderRadius: 12,
                  );
                }),
                40.height,
                Center(
                  child: Text(
                    'Sign Up With',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: 16),
                  ),
                ),
                12.height,
                GoogleLoginButton(
                  onPressed: () {},
                ),
                40.height,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Sign In',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: AppColors.accentTextColor,
                                    fontSize: 16),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
