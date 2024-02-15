import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view/dashboard/new_task/new_task_screen.dart';
import 'package:todo_app/view_model/controller/create_goal/create_goal_controller.dart';

class AddTasksWidget extends StatelessWidget {
  const AddTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<CreateGoalController>(
        builder: (context, value, child) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tasks',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: size.width * 0.9,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (value.goalNameController.text.length < 2) {
                              Utils.flushBarErrorMessage(
                                  'Enter goal name first', context);
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NewTaskScreen()),
                              );
                            }
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
                        const SizedBox(width: 10),
                        const Text(
                          'Add Tasks',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ));
  }
}
