import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/goal_model.dart';
import 'package:todo_app/res/component/task_tile_widget.dart';
import 'package:todo_app/view_model/controller/home/home_controller.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/view_model/services/session_controller.dart';

class TodayUpcomingTasksScreen extends StatelessWidget {
  const TodayUpcomingTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Today Upcoming Tasks')),
      body: Consumer<HomeController>(
        builder: (context, controller, _) {
          // Get today's date in the format "M/d/yyyy"
          String todayDate = DateFormat('M/d/yyyy').format(DateTime.now());

          List<TaskModel> uncompletedUpcomingTasks = controller.upcomingTasks
              .where(
                  (task) => task.startDate == todayDate && !task.isCompleted!)
              .toList();
          return ListView.builder(
            itemCount: uncompletedUpcomingTasks.length,
            itemBuilder: (context, index) {
              TaskModel task = uncompletedUpcomingTasks[index];
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
                          List<Map<String, dynamic>>.from(
                              data['taskList'] ?? []);

                      // Calculate completed tasks count
                      int completedTasksCount = streamTaskList
                          .where((task) => task['isCompleted'] == true)
                          .length;

                      return TaskTileWidget(
                        taskDetail: task,
                        goalName: goalTitle,
                        goalTasksCompletedCount: completedTasksCount,
                        goalTasksTotalCount: streamTaskList.length,
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
        },
      ),
    );
  }
}
