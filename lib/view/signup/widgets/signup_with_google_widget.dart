import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/component/google_login_widget.dart';
import 'package:todo_app/view_model/controller/signup/signup_controller.dart';

class SignupWithGoogleWidget extends StatelessWidget {
  final bool selected;
  const SignupWithGoogleWidget({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: selected
          ? MediaQuery.of(context).size.height * .61
          : MediaQuery.of(context).size.height / .5,
      right: 20,
      left: 20,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
      child: SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width / 2.5,
          child: Consumer<SignupController>(
              builder: (context, value, child) =>
                  GoogleLoginButton(onPressed: () {
                    value.signInWithGoogle(context);
                  }))),
    );
  }
}
