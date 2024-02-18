import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/view_model/controller/create_goal/create_goal_controller.dart';

class AddLinksWidget extends StatelessWidget {
  const AddLinksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(height: 20),
        // Add link
        SizedBox(
          width: size.width * 0.9,
          child: Row(
            children: [
              Consumer<CreateGoalController>(
                builder: (context, value, child) => GestureDetector(
                  onTap: () {
                    value.addLinkDialog(context);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 36, 99, 128),
                        shape: BoxShape.circle),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Text(
                'Add links',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 16, color: AppColors.secondaryTextColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
