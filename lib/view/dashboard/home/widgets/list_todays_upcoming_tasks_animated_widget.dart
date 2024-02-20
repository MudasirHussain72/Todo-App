// ignore_for_file: unused_local_variable
import 'package:action_slider/action_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/goal_model.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/res/component/shimmer_widget.dart';
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
  void _updateTaskCompletionStatus(
    bool completed,
    String goalID,
    String taskID,
  ) async {
    try {
      // Reference to the Firestore task document to be updated
      DocumentReference taskDocumentReference = FirebaseFirestore.instance
          .collection('User')
          .doc(SessionController().user.uid.toString())
          .collection('goals')
          .doc(goalID)
          .collection('tasks')
          .doc(taskID);

      // Update Firestore document with completion status
      await taskDocumentReference.update({
        'isCompleted': completed,
      }).then((value) async {
        var provider = Provider.of<HomeController>(context, listen: false);
        provider.fetchAndSetTasksCount();

        // Check if all tasks under the goal are completed
        QuerySnapshot tasksSnapshot = await FirebaseFirestore.instance
            .collection('User')
            .doc(SessionController().user.uid.toString())
            .collection('goals')
            .doc(goalID)
            .collection('tasks')
            .get();

        bool allTasksCompleted = tasksSnapshot.docs.every(
            (doc) => doc.exists && (doc.data() as Map)['isCompleted'] == true);

        // If all tasks are completed, update the goal's isCompleted field
        if (allTasksCompleted) {
          DocumentReference goalDocumentReference = FirebaseFirestore.instance
              .collection('User')
              .doc(SessionController().user.uid.toString())
              .collection('goals')
              .doc(goalID);

          await goalDocumentReference.update({
            'isCompleted': true,
          }).then((value) {
            var provider = Provider.of<HomeController>(context, listen: false);
            provider.fetchAndSetTasksCount();
          });

          print('Goal completion status updated successfully');
        } else {
          var provider = Provider.of<HomeController>(context, listen: false);
          provider.fetchAndSetTasksCount();
        }
      });

      // Print a message indicating successful update
      print('Task completion status updated successfully');
    } catch (error) {
      // Handle any errors that occur during the update process
      print('Failed to update task completion status: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<HomeController>(builder: (context, controller, _) {
      String todayDate = DateFormat('M/d/yyyy').format(DateTime.now());
      List<TaskModel> uncompletedUpcomingTasks = controller.upcomingTasks
          .where((task) => task.startDate == todayDate && !task.isCompleted!)
          .toList();
      if (controller.fetchAndSetTasksCountLoading) {
        return Center(
            child: ShimmerWidget(
                width: size.width * 0.9, height: size.height / 4));
      }
      if (uncompletedUpcomingTasks.isEmpty) {
        return SizedBox(
          height: size.height / 4,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "📝",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 30),
                    ),
                    Text(
                      " No Tasks For Today",
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

      int itemCount = uncompletedUpcomingTasks.length > 2
          ? 2
          : uncompletedUpcomingTasks.length;

      return ListView.builder(
        itemCount: itemCount,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final task = uncompletedUpcomingTasks[index];

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
                      // debugPrint('index: $index');
                      setState(() {
                        if (animatedContainerIndex == index) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskDetailsScreen(
                                goalID: task.goalId!,
                                taskID: task.taskId!,
                              ),
                            ),
                          );
                        } else {
                          animatedContainerIndex = index;
                        }
                      });
                    },
                    child: AnimatedContainer(
                      margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                      duration: Duration(milliseconds: 1000),
                      height: animatedContainerIndex == index ? 260 : 100,
                      width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)),
                      child: GestureDetector(
                        onTap: () {
                          // debugPrint('index: $index');
                          setState(() {
                            if (animatedContainerIndex == index) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TaskDetailsScreen(
                                    goalID: task.goalId!,
                                    taskID: task.taskId!,
                                  ),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: _parseColor(task.taskColor!, 1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: SingleChildScrollView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      child: Column(
                                        children: [
                                          // Time and edit row
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 20),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.timer_outlined,
                                                  color: Colors.white,
                                                  // size: 30,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Text(
                                                    task.endDate.toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                            color: AppColors
                                                                .whiteColor,
                                                            fontSize: 16),
                                                  ),
                                                ),
                                                const Spacer(),
                                                // GestureDetector(
                                                //   onTap: () {},
                                                //   child: const Icon(
                                                //     Icons.edit_outlined,
                                                //     color: Colors.white,
                                                //     // size: 30,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          // Task name row
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      task.goalName.toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(
                                                              color: AppColors
                                                                  .whiteColor,
                                                              fontSize: 22),
                                                    ),
                                                    Text(
                                                      task.taskTitle.toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(
                                                              color: AppColors
                                                                  .whiteColor,
                                                              fontSize: 20),
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                const Icon(
                                                  Icons.remove_red_eye_rounded,
                                                  color: Colors.white,
                                                  size: 34,
                                                ),
                                                const SizedBox(width: 20),
                                                const Icon(
                                                  Icons.remove_red_eye_rounded,
                                                  color: Colors.white,
                                                  size: 34,
                                                ),
                                              ],
                                            ),
                                          ),

                                          // Action slider
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 20),
                                            child: ActionSlider.standard(
                                              backgroundColor: _parseColor(
                                                  task.taskColor!, 0.4),
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
                                              child: Text(
                                                'Drag to mark done',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color: AppColors
                                                            .whiteColor,
                                                        fontSize: 16),
                                              ),
                                              action: (controller) async {
                                                controller
                                                    .loading(); //starts loading animation
                                                await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 1500));
                                                controller
                                                    .success(); //starts success animation
                                                //starts success animation
                                                _updateTaskCompletionStatus(
                                                  true,
                                                  task.goalId!,
                                                  task.taskId!,
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                      ),
                    ),
                  );
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
