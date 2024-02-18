import 'package:flutter/material.dart';
import 'package:todo_app/res/colors.dart';

class GoogleLoginButton extends StatelessWidget {
  final Function() onPressed;
  const GoogleLoginButton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 54,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.slate400, width: 1.0),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)))),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/google_logo.png",
                width: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Google",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 16,
                      color: AppColors.primaryColor,
                    ),
              ),
            ],
          ),
        ));
  }
}
