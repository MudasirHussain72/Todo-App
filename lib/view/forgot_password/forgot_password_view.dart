import 'package:flutter/material.dart';
import 'package:todo_app/view/forgot_password/forgot_password_button_widget.dart';
import 'package:todo_app/view/forgot_password/forgot_password_text_widget.dart';
import 'package:todo_app/view/forgot_password/widgets/forgot_password_email.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
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
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              ForgotPasswordTextWidget(selected: isAnimationStart),
              ForgotPasswordEmailInputTextFiled(selected: isAnimationStart),
              ForgotPasswordButtonWidget(selected: isAnimationStart)
            ],
          ),
        ),
      ),
    );
  }
}
