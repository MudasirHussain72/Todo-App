import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/goal_model.dart';
import 'package:todo_app/view/dashboard/home/goal_detail_screen.dart';
import 'package:todo_app/view_model/controller/home/home_controller.dart';

class ListGoalsInHorizontalWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<HomeController>(
      builder: (context, controller, _) {
        List<GoalsModel> goalList = controller.goalsList;

        return Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SizedBox(
            height: 110,
            child: ListView.builder(
              itemCount: goalList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                GoalsModel goal = goalList[index];
                int totalTasks = goal.taskList!.length;
                int completedTasks =
                    goal.taskList!.where((task) => task.isCompleted!).length;
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
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'completed',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey,
                                        ),
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
