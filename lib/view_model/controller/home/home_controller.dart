import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/model/goal_model.dart';
import 'package:todo_app/view_model/services/session_controller.dart';

class HomeController with ChangeNotifier {
  bool _fetchAndSetTasksCountLoading = false;
  bool get fetchAndSetTasksCountLoading => _fetchAndSetTasksCountLoading;
  setFetchAndSetTasksCountLoading(bool value) {
    _fetchAndSetTasksCountLoading = value;
    notifyListeners();
  }

  int _completedTasksCount = 0;
  int get completedTasksCount => _completedTasksCount;
  setCompletedTasksCount(int value) {
    _completedTasksCount = value;
    notifyListeners();
  }

  int _totalTasksCount = 0;
  int get totalTasksCount => _totalTasksCount;
  setTotalTasksCount(int value) {
    _totalTasksCount = value;
    notifyListeners();
  }

  int _upcomingTasksCount = 0;
  int get upcomingTasksCount => _upcomingTasksCount;
  setUpcomingTasksCount(int value) {
    _upcomingTasksCount = value;
    notifyListeners();
  }

  List<TaskModel> _upcomingTasks = [];
  List<TaskModel> get upcomingTasks => _upcomingTasks;
  setUpcomingTasks(List<TaskModel> tasks) {
    _upcomingTasks = tasks;
    notifyListeners();
  }

  List<GoalsModel> _goalsList = [];
  List<GoalsModel> get goalsList => _goalsList;
  setGoalsList(List<GoalsModel> value) {
    _goalsList = value;
    notifyListeners();
  }

  Future<void> fetchAndSetTasksCount() async {
    setFetchAndSetTasksCountLoading(true);
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('User')
          .doc(SessionController().user.uid)
          .collection('goals')
          .get();

      // Convert querySnapshot to a List of Map<String, dynamic>
      List<Map<String, dynamic>> goalsData = [];
      querySnapshot.docs.forEach((doc) {
        goalsData.add(doc.data() as Map<String, dynamic>);
      });

      // Convert goalsData to a List of GoalsModel instances
      List<GoalsModel> goals =
          goalsData.map((data) => GoalsModel.fromJson(data)).toList();

      // Store the goals list in HomeController
      setGoalsList(goals);

      // Get today's date in the format "M/d/yyyy"
      String todayDate = DateFormat('M/d/yyyy').format(DateTime.now());

      // Calculate completed, total, and upcoming tasks count for the current date
      int completedTasksCount = 0;
      int totalTasksCount = 0;
      int upcomingTasksCount = 0;
      List<TaskModel> upcomingTasks = [];

      goals.forEach((goal) {
        Map<String, int> tasksCount =
            goal.calculateCompletedTasksCount(todayDate);
        completedTasksCount += tasksCount['completed']!;
        totalTasksCount += tasksCount['total']!;

        // Check for upcoming tasks for today
        goal.taskList!.forEach((task) {
          if (task.startDate == todayDate && !task.isCompleted!) {
            upcomingTasksCount++;
            upcomingTasks.add(task);
          }
        });
      });

      // Store the completed, total, and upcoming tasks count in HomeController
      setCompletedTasksCount(completedTasksCount);
      setTotalTasksCount(totalTasksCount);
      setUpcomingTasksCount(upcomingTasksCount);
      setUpcomingTasks(upcomingTasks);
    } catch (error) {
      print("Failed to get goals: $error");
    } finally {
      setFetchAndSetTasksCountLoading(false);
    }
  }
}
