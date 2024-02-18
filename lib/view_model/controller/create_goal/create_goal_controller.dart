import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/goal_model.dart';
import 'package:todo_app/view_model/controller/home/home_controller.dart';
import 'package:todo_app/view_model/services/session_controller.dart';
import 'package:uuid/uuid.dart';
import '../../../utils/utils.dart';

class CreateGoalController with ChangeNotifier {
  TextEditingController goalNameController = TextEditingController();
  TextEditingController goalDescController = TextEditingController();
  final goalNameFocusNode = FocusNode();
  final goalDescFocusNode = FocusNode();
  //add task variables
  TextEditingController taskNameController = TextEditingController();
  final taskNameFocusNode = FocusNode();
  TextEditingController startDateController =
      TextEditingController(text: 'Beginning date');
  TextEditingController endDateController =
      TextEditingController(text: 'End date');

  List<TaskModel> _tasksList = [];
  List<TaskModel> get tasksList => _tasksList;
  Future<void> addTaskToTaskList(TaskModel value) async {
    _tasksList.add(value);
    log(tasksList.length.toString());
    notifyListeners();
  }

  Future<void> clearTaskList() async {
    _tasksList.clear();
    log(_tasksList.length.toString());
    notifyListeners();
  }

  List<String> _tasksLinks = [];
  List<String> get tasksLinks => _tasksLinks;
  Future<void> addTaskLinks(String value) async {
    _tasksLinks.add(value);
    log(_tasksLinks.length.toString());
    notifyListeners();
  }

  Future<void> clearTaskLinks() async {
    _tasksLinks.clear();
    log(_tasksLinks.length.toString());
    notifyListeners();
  }

  String _selectedGoalColorCode = '8bc34a';
  String get selectedGoalColorCode => _selectedGoalColorCode;
  setGoalColorCode(String value) {
    _selectedGoalColorCode = value;
    log(selectedGoalColorCode);
    notifyListeners();
  }

  String _selectedTaskColorCode = '9c27b0';
  String get selectedTaskColorCode => _selectedTaskColorCode;
  setTaskColorCode(String value) {
    _selectedTaskColorCode = value;
    log(selectedTaskColorCode);
    notifyListeners();
  }

  String _selectedGoalType = '';
  String get selectedGoalType => _selectedGoalType;
  setGoalType(String value) {
    _selectedGoalType = value;
    log(_selectedGoalType);
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  String _goalId = const Uuid().v4();
  String get goalId => _goalId;
  setNewValueToGoalId() {
    _goalId = const Uuid().v4();
    log(_goalId);
    notifyListeners();
  }

  // var taskId = Uuid().v4();
  String _taskId = '';
  String get taskId => _taskId;
  setTaskId() {
    _taskId = const Uuid().v4();
    log(_taskId);
    notifyListeners();
  }

  resetTaskId() {
    _taskId = '';
    log(_taskId);
    notifyListeners();
  }

  // Method to show the dialog
  Future<void> addLinkDialog(BuildContext context) async {
    TextEditingController linkController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Link'),
            content: TextField(
              controller: linkController,
              decoration: const InputDecoration(hintText: 'Enter link'),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('Add'),
                  onPressed: () {
                    String link = linkController.text
                        .trim(); // Trim to remove leading and trailing spaces
                    if (link.isNotEmpty) {
                      addTaskLinks(link)
                          .then((value) => Navigator.pop(context));
                    } else {
                      // Show a message indicating that the link cannot be empty
                      Utils.flushBarErrorMessage(
                          'Link cannot be empty', context);
                    }
                  }),
            ],
          );
        });
  }

  // Function for createGoal
  Future<void> createGoal(BuildContext context) async {
    setLoading(true);
    var goalData = GoalsModel(
      goalNameController.text.trim(),
      false,
      0.toString(),
      selectedGoalColorCode,
      goalDescController.text.trim(),
      // tasksList,
      _goalId,
    );
    try {
      // Save goal data to Firestore
      await FirebaseFirestore.instance
          .collection('User')
          .doc(SessionController().user.uid)
          .collection('goals')
          .doc(_goalId)
          .set(goalData.toJson());

// Now, add tasks to the 'tasks' collection under the goal document
      for (var task in _tasksList) {
        await FirebaseFirestore.instance
            .collection('User')
            .doc(SessionController().user.uid)
            .collection('goals')
            .doc(_goalId)
            .collection('tasks')
            .doc(task.taskId) // Use the task ID as the document ID
            .set(task.toJson());
      }

      // Clear controllers and lists after successful creation
      goalNameController.clear();
      goalDescController.clear();
      clearTaskList();
      clearTaskLinks();
      setNewValueToGoalId(); // Generate new goal ID
      resetTaskId(); // Reset task ID
      setGoalColorCode('8bc34a'); // Reset goal color
      setTaskColorCode('9c27b0'); // Reset task color
      setGoalType(''); // Reset goal type

      // Show success message
      Utils.flushBarDoneMessage('Goal Created', context);

      // Fetch and set tasks count to reflect changes
      var homeController = Provider.of<HomeController>(context, listen: false);
      await homeController.fetchAndSetTasksCount();
    } catch (e) {
      Utils.flushBarErrorMessage(e.toString(), context);
    } finally {
      setLoading(false);
    }
  }
}
