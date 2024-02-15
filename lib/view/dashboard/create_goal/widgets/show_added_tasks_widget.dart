import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/component/task_tile_widget.dart';
import 'package:todo_app/view_model/controller/create_goal/create_goal_controller.dart';

class ShowAddedTasksWidget extends StatelessWidget {
  const ShowAddedTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateGoalController>(builder: (context, value, child) {
      if (value.tasksList.isNotEmpty) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.tasksList.length,
              itemBuilder: (context, index) {
                var provider = Provider.of<CreateGoalController>(context);
                return TaskTileWidget(
                  taskDetail: value.tasksList[index],
                  goalName: provider.goalNameController.text.trim(),
                  goalTasksCompletedCount: 0,
                  goalTasksTotalCount: value.tasksList.length,
                );
              }),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
