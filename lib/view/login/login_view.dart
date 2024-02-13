import 'package:flutter/material.dart';
import 'package:todo_app/view/login/widgets/forgot_text_widget.dart';
import 'package:todo_app/view/login/widgets/goto_signup_widget.dart';
import 'package:todo_app/view/login/widgets/login-button_widget.dart';
import 'package:todo_app/view/login/widgets/login_input_email_text.dart';
import 'package:todo_app/view/login/widgets/login_password_input_text_field.dart';
import 'package:todo_app/view/login/widgets/login_with_widget.dart';
import 'package:todo_app/view/login/widgets/signin_with_text_widget.dart';
import 'package:todo_app/view/login/widgets/welcome_back_text_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isAnimationStart = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => isAnimationStart = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 1;
    var height = MediaQuery.of(context).size.height * .8;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              WelcomeBackTextWidget(selected: isAnimationStart),
              LoginEmailInputTextFiled(selected: isAnimationStart),
              LoginPasswordInputTextFiled(selected: isAnimationStart),
              ForgotTextWidget(selected: isAnimationStart),
              LoginButtonWidget(selected: isAnimationStart),
              SigninWithTextWidget(selected: isAnimationStart),
              LoginWithGoogleWidget(selected: isAnimationStart),
              GotoSignupWidget(selected: isAnimationStart),
            ],
          ),
        ),
      ),
    );
  }
}
