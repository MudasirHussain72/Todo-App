import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:todo_app/model/goal_model.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/view/dashboard/home/task_detail_screen.dart';

// ignore: must_be_immutable
class GoalsDetailScreen extends StatefulWidget {
  GoalsModel? goalsData;
  GoalsDetailScreen({super.key, this.goalsData});

  @override
  State<GoalsDetailScreen> createState() => _GoalsDetailScreenState();
}

class _GoalsDetailScreenState extends State<GoalsDetailScreen> {
  List<TaskModel> taskList = [
    TaskModel(
      'English C1',
      '093947',
      '2/14/2024',
      'Developer',
      ['https://youtube.com', 'https://youtube.com' 'https://youtube.com'],
      '2/14/2024',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Goal Details',
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w800),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.edit,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                SizedBox(
                  width: size.width * 0.9,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(
                                int.parse('0xff${widget.goalsData!.goalColor}'))
                            .withOpacity(0.8),
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Text(
                                widget.goalsData!.goalTitle.toString(),
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.edit_outlined,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0),
                          child: Text(
                            widget.goalsData!.goalCompleted.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          child: LinearPercentIndicator(
                            animation: true,
                            lineHeight: 20.0,
                            animationDuration: 2000,
                            percent: double.parse(
                                    widget.goalsData!.percentage.toString()) /
                                100,
                            backgroundColor: Colors.grey[200]!,
                            curve: Curves.easeInOut,
                            barRadius: const Radius.circular(20),
                            progressColor: Color(int.parse(
                                '0xff${widget.goalsData!.goalColor}')),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey)),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 5),
                        child: Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: Text(
                          'English is the one of the most widely spoken language in the world.',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 5),
                        child: Text(
                          'Useful Materials',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20),
                        child: GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'https://www.youtube.com/watch?v=c2JNZ8nxCCU',
                            // maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Tasks',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: size.width * 0.9,
                  child: ListView.builder(
                      itemCount: taskList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TaskDetailsScreen(
                                          taskDetail: taskList[index],
                                        ))),
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),

                                // border
                                border: Border(
                                    left: BorderSide(
                                  color: Color(int.parse(
                                      '0xff${widget.goalsData!.goalColor}')),
                                  width: 15,
                                )),
                              ),
                              child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: Colors.grey),
                                      right: BorderSide(color: Colors.grey),
                                      bottom: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              taskList[index]
                                                  .taskTitle
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const Spacer(),
                                            Text(
                                              taskList[index]
                                                  .endDate
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              // taskList[index]
                                              //     .taskSubTitle
                                              //     .toString(),
                                              'English Lesson',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ) // end upcoming task container
                                  ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
