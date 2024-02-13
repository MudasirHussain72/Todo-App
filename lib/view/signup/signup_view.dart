import 'package:flutter/material.dart';
import 'package:todo_app/view/signup/widgets/create_account_text_widget.dart';
import 'package:todo_app/view/signup/widgets/goto_login_widget.dart';
import 'package:todo_app/view/signup/widgets/signup_input_email_text.dart';
import 'package:todo_app/view/signup/widgets/signup_input_name_text.dart';
import 'package:todo_app/view/signup/widgets/signup_login_widget.dart';
import 'package:todo_app/view/signup/widgets/signup_password_input_text_field.dart';
import 'package:todo_app/view/signup/widgets/signup_with_google_widget.dart';
import 'package:todo_app/view/signup/widgets/signup_with_text_widget.dart';

class SignupView extends StatefulWidget {
  SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
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
              CreateAccountTextWidget(selected: isAnimationStart),
              SignupNameInputTextFiled(selected: isAnimationStart),
              SignupEmailInputTextFiled(selected: isAnimationStart),
              SignupPasswordInputTextFiled(selected: isAnimationStart),
              SignupLoginWidget(selected: isAnimationStart),
              SigninWithTextWidget(selected: isAnimationStart),
              SignupWithGoogleWidget(selected: isAnimationStart),
              GotoLoginWidget(selected: isAnimationStart),
            ],
          ),
        ),
      ),
    );
  }
}
