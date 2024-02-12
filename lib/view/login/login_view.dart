import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/res/component/google_login_widget.dart';
import 'package:todo_app/res/component/round_button.dart';
import 'package:todo_app/res/extensions.dart';
import 'package:todo_app/utils/routes/route_name.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view/login/widgets/login_input_email_text.dart';
import 'package:todo_app/view/login/widgets/login_password_input_text_field.dart';
import 'package:todo_app/view_model/controller/login/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
                  'Hi Welcome Back 👋',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontSize: 26),
                ),
                6.height,
                Text(
                  'Please enter your e-mail and password for login',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 20),
                ),
                30.height,
                const LoginEmailInputTextFiled(),
                6.height,
                const LoginPasswordInputTextFiled(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, RouteName.forgotView),
                      child: Text(
                        'Forgot Password?',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.accentTextColor, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                30.height,
                Consumer<LoginController>(builder: (context, provider, child) {
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
                        provider.login(context);
                      }
                    },
                    borderRadius: 12,
                  );
                }),
                40.height,
                Center(
                  child: Text(
                    'Signin With',
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
                      "Not registered yet? ",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, RouteName.signUpView),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Sign Up',
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
