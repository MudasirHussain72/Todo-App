import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/goal_model.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view_model/controller/create_goal/create_goal_controller.dart';

class CreateTaskAppbar extends StatefulWidget implements PreferredSizeWidget {
  CreateTaskAppbar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CreateTaskAppbarState createState() => _CreateTaskAppbarState();
}

class _CreateTaskAppbarState extends State<CreateTaskAppbar> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return AppBar(
      title: const Text(
        'New Task',
        style: TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.w800),
      ),
      leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Consumer<CreateGoalController>(
            builder: (context, value, child) => GestureDetector(
              onTap: () {
                value.tasksLinks.clear();
                Navigator.pop(context);
              },
              child: const Icon(Icons.close, color: Colors.black),
            ),
          )),
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Consumer<CreateGoalController>(
                builder: (context, provider, child) => GestureDetector(
                      onTap: () {
                        if (provider.taskNameController.text.length < 2) {
                          Utils.flushBarErrorMessage(
                              'Enter task name', context);
                        } else if (provider.startDateController.text ==
                            'Beginning date') {
                          Utils.flushBarErrorMessage(
                              'Select start date', context);
                        } else if (provider.endDateController.text ==
                            'End date') {
                          Utils.flushBarErrorMessage(
                              'Select end date', context);
                        } else if (provider.selectedGoalType == '') {
                          Utils.flushBarErrorMessage(
                              'Select goal type', context);
                        } else {
                          provider
                              .addTaskToTaskList(
                            TaskModel(
                              provider.taskNameController.text.trim(),
                              provider.selectedTaskColorCode,
                              provider.endDateController.text.trim(),
                              provider.selectedGoalType,
                              provider.tasksLinks,
                              provider.startDateController.text.trim(),
                            ),
                          )
                              .then((value) {
                            provider.taskNameController.clear();
                            provider.startDateController.text =
                                'Beginning date';
                            provider.endDateController.text = 'End date';
                            Navigator.pop(context);
                          });
                        }
                      },
                      child: Text('Add',
                          style: textTheme.bodySmall!.copyWith(fontSize: 18)),
                    ))),
      ],
    );
  }
}
