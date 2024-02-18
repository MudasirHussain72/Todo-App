import 'package:flutter/material.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/view/dashboard/home/goals_screen.dart';

class GoalsProgressTextAndSeeAllWidget extends StatelessWidget {
  const GoalsProgressTextAndSeeAllWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width * 0.48,
            child: Text(
              'Goals Progress',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 18, color: AppColors.secondaryTextColor),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GoalsScreen(),
                  ));
            },
            child: Text(
              'See all',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.primaryTextColor),
            ),
          )
        ],
      ),
    );
  }
}
