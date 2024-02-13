import 'package:flutter/material.dart';

class SigninWithTextWidget extends StatelessWidget {
  final bool selected;
  const SigninWithTextWidget({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: selected
          ? MediaQuery.of(context).size.height * .56
          : MediaQuery.of(context).size.height / .5,
      right: 20,
      left: 20,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
      child: Center(
        child: Text(
          'Signin With',
          style:
              Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16),
        ),
      ),
    );
  }
}
