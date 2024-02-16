// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'package:action_slider/action_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/goal_model.dart';
import 'package:todo_app/res/component/task_tile_widget.dart';
import 'package:todo_app/view/dashboard/home/task_detail_screen.dart';
import 'package:todo_app/view_model/controller/home/home_controller.dart';
import 'package:todo_app/view_model/services/session_controller.dart';

class ListTodaysUpcomingTasksAnimatedWidget extends StatefulWidget {
  ListTodaysUpcomingTasksAnimatedWidget({Key? key}) : super(key: key);

  @override
  _ListTodaysUpcomingTasksAnimatedWidgetState createState() =>
      _ListTodaysUpcomingTasksAnimatedWidgetState();
}

class _ListTodaysUpcomingTasksAnimatedWidgetState
    extends State<ListTodaysUpcomingTasksAnimatedWidget> {
  int animatedContainerIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<HomeController>(builder: (context, controller, _) {
      String todayDate = DateFormat('M/d/yyyy').format(DateTime.now());
      List<TaskModel> uncompletedUpcomingTasks = controller.upcomingTasks
          .where((task) => task.startDate == todayDate && !task.isCompleted!)
          .toList();

      if (uncompletedUpcomingTasks.isEmpty) {
        return Center(
          child: Text("No tasks for today."),
        );
      }

      int itemCount = uncompletedUpcomingTasks.length > 2
          ? 2
          : uncompletedUpcomingTasks.length;

      return ListView.builder(
        itemCount: itemCount,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final task = uncompletedUpcomingTasks[index];
          log(task.taskColor.toString());

          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('User')
                .doc(SessionController().user.uid)
                .collection('goals')
                .doc(task.goalId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!.data() as Map<String, dynamic>?;
                if (data != null && snapshot.data!.exists) {
                  String goalTitle = data['goalTitle'] ?? '';
                  List<Map<String, dynamic>> streamTaskList =
                      List<Map<String, dynamic>>.from(data['taskList'] ?? []);

                  // Calculate completed tasks count
                  int completedTasksCount = streamTaskList
                      .where((task) => task['isCompleted'] == true)
                      .length;

                  return InkWell(
                      onTap: () {
                        debugPrint('index: $index');
                        setState(() {
                          if (animatedContainerIndex == index) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TaskDetailsScreen(
                                  goalTasksCompletedCount: completedTasksCount,
                                  goalTasksTotalCount: streamTaskList.length,
                                  taskDetail: task,
                                ),
                              ),
                            );
                          } else {
                            animatedContainerIndex = index;
                          }
                        });
                      },
                      child: AnimatedContainer(
                          margin:
                              EdgeInsets.only(bottom: 10, left: 20, right: 20),
                          duration: Duration(milliseconds: 1500),
                          height: animatedContainerIndex == index ? 260 : 100,
                          width: size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)),
                          child: GestureDetector(
                              onTap: () {
                                debugPrint('index: $index');
                                setState(() {
                                  if (animatedContainerIndex == index) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TaskDetailsScreen(
                                            goalTasksCompletedCount:
                                                completedTasksCount,
                                            goalTasksTotalCount:
                                                streamTaskList.length,
                                            taskDetail: task),
                                      ),
                                    );
                                  } else {
                                    animatedContainerIndex = index;
                                  }
                                });
                              },
                              child: animatedContainerIndex != index
                                  ? TaskTileWidget(
                                      goalName: 'goalName',
                                      goalTasksCompletedCount: 1,
                                      goalTasksTotalCount: 1,
                                      taskDetail: task,
                                      marginLeft: 0,
                                      marginRight: 0,
                                      marginTop: 0,
                                      isOnTapDisabled: true,
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                _parseColor(task.taskColor!, 1),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: SingleChildScrollView(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            child: Column(
                                              children: [
                                                // Time and edit row
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20,
                                                      vertical: 20),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.timer_outlined,
                                                        color: Colors.white,
                                                        size: 30,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 5),
                                                        child: Text(
                                                          task.endDate
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      GestureDetector(
                                                        onTap: () {},
                                                        child: const Icon(
                                                          Icons.edit_outlined,
                                                          color: Colors.white,
                                                          size: 30,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Task name row
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20,
                                                      vertical: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            task.goalName
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          Text(
                                                            task.taskTitle
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 25,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                      const Spacer(),
                                                      const Icon(
                                                        Icons
                                                            .remove_red_eye_rounded,
                                                        color: Colors.white,
                                                        size: 40,
                                                      ),
                                                      const SizedBox(width: 20),
                                                      const Icon(
                                                        Icons
                                                            .remove_red_eye_rounded,
                                                        color: Colors.white,
                                                        size: 40,
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                // Action slider
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20,
                                                      vertical: 20),
                                                  child: ActionSlider.standard(
                                                    backgroundColor:
                                                        _parseColor(
                                                            task.taskColor!,
                                                            0.4),
                                                    toggleColor: _parseColor(
                                                        task.taskColor!, 0.3),
                                                    rolling: true,
                                                    icon: const Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: Colors.white,
                                                    ),
                                                    loadingIcon: const Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                    ),
                                                    child: const Text(
                                                      'Drag to mark done',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    action: (controller) async {
                                                      controller
                                                          .loading(); //starts loading animation
                                                      await Future.delayed(
                                                          const Duration(
                                                              seconds: 3));
                                                      controller
                                                          .success(); //starts success animation
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ))));
                } else {
                  // Handle case when data is null or document doesn't exist
                  return TaskTileWidget(
                    taskDetail: task,
                    goalName: 'Error Goal title',
                    goalTasksCompletedCount: 0,
                    goalTasksTotalCount: 1,
                  ); // Or any other loading indicator
                }
              } else {
                // Handle loading state
                return TaskTileWidget(
                  taskDetail: task,
                  goalName: 'Loading',
                  goalTasksCompletedCount: 0,
                  goalTasksTotalCount: 1,
                ); // Or any other loading indicator
              }
            },
          );
        },
      );
    });
  }

  Color _parseColor(String colorString, double opacity) {
    if (colorString != 'null') {
      return Color(int.parse(colorString, radix: 16)).withOpacity(opacity);
    } else {
      return Colors.grey.withOpacity(opacity);
    }
  }
}
