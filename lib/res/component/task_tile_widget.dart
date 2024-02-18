import 'package:flutter/material.dart';
import 'package:todo_app/model/goal_model.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/view/dashboard/home/task_detail_screen.dart';

class TaskTileWidget extends StatelessWidget {
  final TaskModel? taskDetail;
  final String goalName;
  final int goalTasksCompletedCount, goalTasksTotalCount;
  final double marginTop, marginRight, marginLeft;
  final bool isOnTapDisabled;
  const TaskTileWidget({
    super.key,
    this.taskDetail,
    required this.goalName,
    required this.goalTasksCompletedCount,
    required this.goalTasksTotalCount,
    this.marginTop = 10,
    this.marginRight = 20,
    this.marginLeft = 20,
    this.isOnTapDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isOnTapDisabled
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskDetailsScreen(
                    taskID: taskDetail!.taskId.toString(),
                    goalID: taskDetail!.goalId.toString(),
                  ),
                ),
              );
            },
      child: Container(
        height: 100,
        margin: EdgeInsets.only(
            top: marginTop, left: marginLeft, right: marginRight),
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
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 18, color: AppColors.secondaryTextColor),
                      ),
                      const Spacer(),
                      Text(
                        taskDetail!.endDate.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: AppColors.primaryTextColor),
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
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: AppColors.primaryTextColor),
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
