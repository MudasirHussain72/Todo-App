import 'package:flutter/material.dart';
import 'package:todo_app/res/colors.dart';

class GotoLoginWidget extends StatelessWidget {
  final bool selected;
  const GotoLoginWidget({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        top: selected
            ? MediaQuery.of(context).size.height * .58
            : MediaQuery.of(context).size.height / .5,
        right: MediaQuery.of(context).size.width / 4.1,
        duration: const Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
        child: Row(
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
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.accentTextColor, fontSize: 16),
                  )),
            ),
          ],
        ));
  }
}
