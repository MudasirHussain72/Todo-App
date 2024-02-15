import 'package:flutter/material.dart';
import 'package:todo_app/model/goal_model.dart';
import 'package:todo_app/view/dashboard/home/task_detail_screen.dart';

class TaskTileWidget extends StatelessWidget {
  final TaskModel? taskDetail;
  final String goalName;
  final int goalTasksCompletedCount, goalTasksTotalCount;
  const TaskTileWidget(
      {super.key,
      this.taskDetail,
      required this.goalName,
      required this.goalTasksCompletedCount,
      required this.goalTasksTotalCount});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TaskDetailsScreen(
                    taskDetail: taskDetail,
                    goalTasksCompletedCount: goalTasksCompletedCount,
                    goalTasksTotalCount: goalTasksTotalCount,
                  )),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),

          // border
          border: Border(
              left: BorderSide(
            color: Color(
                int.parse(taskDetail!.taskColor!, radix: 16) + 0xFF000000),
            width: 15,
          )),
        ),
        child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              border: Border(
                top: BorderSide(color: Colors.grey),
                right: BorderSide(color: Colors.grey),
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        taskDetail!.taskTitle.toString(),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Text(
                        taskDetail!.endDate.toString(),
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        goalName,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
