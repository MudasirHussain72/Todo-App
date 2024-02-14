import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            itemBuilder: (context, index) => ListTile(
              title: Text(value.tasksList[index].toString()),
            ),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
