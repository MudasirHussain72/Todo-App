import 'package:flutter/material.dart';

class ForgotPasswordTextWidget extends StatelessWidget {
  final bool selected;
  const ForgotPasswordTextWidget({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        top: selected
            ? MediaQuery.of(context).size.height * .10
            : MediaQuery.of(context).size.height / 1.1,
        // right: MediaQuery.of(context).size.width / 3,
        duration: const Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: RichText(
            text: TextSpan(
              text: 'Forgot\nPassword?\n\n',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: 26),
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Don\'t worry it happens\nJust Enter Email We Will Send You Email\nTo Recover Your Password',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 20),
                ),
              ],
            ),
          ),
        ));
  }
}
