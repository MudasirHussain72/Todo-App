import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/goal_model.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/view/dashboard/home/goal_detail_screen.dart';
import 'package:todo_app/view_model/controller/home/home_controller.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Goals')),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(child: Consumer<HomeController>(
                builder: (context, controller, _) {
                  List<GoalsModel> goalList = controller.goalsList;
                  if (goalList.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              color: AppColors.accentColor,
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            "Go ahead & create one",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontSize: 16, color: AppColors.whiteColor),
                          ),
                        ),
                      ],
                    );
                  }
                  return SizedBox(
                    height: 110,
                    child: ListView.builder(
                      itemCount: goalList.length,
                      itemBuilder: (context, index) {
                        GoalsModel goal = goalList[index];
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
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
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
                                                        color: AppColors
                                                            .primaryTextColor),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                'Completed',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color: AppColors
                                                            .primaryTextColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        // CircularPercentIndicator(
                                        //   radius: 40.0,
                                        //   lineWidth: 8.0,
                                        //   percent: percentage / 100,
                                        //   center: Text(
                                        //     '${percentage.toStringAsFixed(0)}%',
                                        //   ),
                                        //   progressColor: Color(int.parse(
                                        //       '0xff${goal.goalColor}')),
                                        // ),
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
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
