import 'package:flutter/material.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/utils/routes/route_name.dart';

class GotoSignupWidget extends StatelessWidget {
  final bool selected;
  const GotoSignupWidget({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        top: selected
            ? MediaQuery.of(context).size.height * .56
            : MediaQuery.of(context).size.height / .5,
        right: MediaQuery.of(context).size.width / 3.6,
        duration: const Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
        child: SizedBox(
          height: 50,
          // width: width / 2.5,
          child: Row(
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
                onTap: () => Navigator.pushNamed(context, RouteName.signUpView),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.accentTextColor, fontSize: 16),
                    )),
              ),
            ],
          ),
        ));
  }
}
