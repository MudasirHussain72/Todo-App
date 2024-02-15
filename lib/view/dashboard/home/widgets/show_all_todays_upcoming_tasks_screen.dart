import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/goal_model.dart';
import 'package:todo_app/res/component/task_tile_widget.dart';
import 'package:todo_app/view_model/controller/home/home_controller.dart';
import 'package:intl/intl.dart';

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
              return TaskTileWidget(
                  goalName: task.goalName ?? '',
                  taskDetail: task,
                  goalTasksCompletedCount: 1,
                  goalTasksTotalCount: 1);
              // ListTile(
              //   title: Text(task.taskTitle ?? ''),
              //   subtitle: Text(task.goalName ?? ''),
              //   // Add more details or customize as needed
              // );
            },
          );
        },
      ),
    );
  }
}
