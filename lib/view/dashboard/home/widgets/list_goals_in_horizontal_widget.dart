import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo_app/model/goal_model.dart';
import 'package:todo_app/view/dashboard/home/goal_detail_screen.dart';

// ignore: must_be_immutable
class ListGoalsInHorizontalWidget extends StatelessWidget {
  ListGoalsInHorizontalWidget({super.key});
  List<GoalsModel> goalList = [
    GoalsModel(
      'English C1',
      false,
      1.toString(),
      '004c00',
      'desc',
      [],
      '004c00',
    ),
    GoalsModel(
      'English C1',
      false,
      1.toString(),
      '004c00',
      'desc',
      [],
      '004c00',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: SizedBox(
        height: 110,
        child: ListView.builder(
            itemCount: goalList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GoalsDetailScreen(
                                goalsData: goalList[index],
                              ))),
                  child: Container(
                    width: size.width * 0.7,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 12),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      goalList[index].goalTitle.toString(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      // goalList[index]
                                      //     .isCompleted
                                      //     .toString(),
                                      'completed',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey),
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
                                  percent: double.parse(goalList[index]
                                          .percentage
                                          .toString()) /
                                      100,
                                  center: Text(
                                    '${goalList[index].percentage.toString()}%',
                                  ),
                                  progressColor: Color(int.parse(
                                      '0xff${goalList[index].goalColor}')),
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
            }),
      ),
    );
  }
}
