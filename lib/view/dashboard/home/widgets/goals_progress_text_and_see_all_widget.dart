import 'package:flutter/material.dart';
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
            child: const Text(
              'Goals Progress',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
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
              style: TextStyle(fontSize: 16, color: Colors.grey[700]!),
            ),
          )
        ],
      ),
    );
  }
}
