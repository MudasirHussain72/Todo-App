import 'package:flutter/material.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/utils/routes/route_name.dart';

class ForgotTextWidget extends StatelessWidget {
  final bool selected;
  const ForgotTextWidget({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: selected
          ? MediaQuery.of(context).size.height * .38
          : MediaQuery.of(context).size.height / .5,
      right: 20,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, RouteName.forgotView),
        child: Text(
          'Forgot Password?',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: AppColors.accentTextColor, fontSize: 16),
        ),
      ),
    );
  }
}
