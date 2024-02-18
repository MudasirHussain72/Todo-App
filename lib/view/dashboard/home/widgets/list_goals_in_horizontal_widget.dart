import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/goal_model.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/res/component/shimmer_widget.dart';
import 'package:todo_app/view/dashboard/home/goal_detail_screen.dart';
import 'package:todo_app/view_model/controller/home/home_controller.dart';

class ListGoalsInHorizontalWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<HomeController>(
      builder: (context, controller, _) {
        List<GoalsModel> goalList = controller.goalsList;
        List<TaskModel> taskList = controller.tasksList;
        if (controller.fetchAndSetTasksCountLoading) {
          return Center(
              child: ShimmerWidget(
            width: size.width * 0.9,
            height: 110,
          ));
        }
        if (goalList.isEmpty) {
          return SizedBox(
            // height: size.height * .1,
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "🎯 ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 30),
                      ),
                      Text(
                        " No goals created",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 24),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: AppColors.accentColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      "Go ahead & create one",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 16, color: AppColors.whiteColor),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SizedBox(
            height: 110,
            child: ListView.builder(
              itemCount: goalList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                GoalsModel goal = goalList[index];
                // Filter tasks related to the current goal
                List<TaskModel> tasksForGoal = taskList
                    .where((task) => task.goalId == goal.goalId)
                    .toList();
                int totalTasks = tasksForGoal.length;
                int completedTasks =
                    tasksForGoal.where((task) => task.isCompleted!).length;
                double percentage =
                    totalTasks != 0 ? (completedTasks / totalTasks) * 100 : 0;
                print(percentage);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoalsDetailScreen(
                          goalsData: goal,
                        ),
                      ),
                    ),
                    child: Container(
                      width: size.width * 0.7,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 12),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        goal.goalTitle.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                fontSize: 18,
                                                color: AppColors
                                                    .secondaryTextColor),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '$completedTasks/$totalTasks',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color:
                                                    AppColors.primaryTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: CircularPercentIndicator(
                                    radius: 40.0,
                                    lineWidth: 8.0,
                                    percent: percentage / 100,
                                    center: Text(
                                      '${percentage.toStringAsFixed(0)}%',
                                    ),
                                    progressColor: Color(
                                        int.parse('0xff${goal.goalColor}')),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
