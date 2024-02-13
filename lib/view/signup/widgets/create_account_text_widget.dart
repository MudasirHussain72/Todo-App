import 'package:flutter/material.dart';
import 'package:todo_app/res/extensions.dart';

class CreateAccountTextWidget extends StatelessWidget {
  final bool selected;
  const CreateAccountTextWidget({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: selected
          ? MediaQuery.of(context).size.height * .12
          : MediaQuery.of(context).size.height / 1.1,
      // right: MediaQuery.of(context).size.width / 3,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create an account',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: 26),
            ),
            6.height,
            Text(
              'Please enter your information and\ncreate your account',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
