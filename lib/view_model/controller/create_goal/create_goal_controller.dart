import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo_app/model/task_model.dart';
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

  List<String> _tasksLinks = [];
  List<String> get tasksLinks => _tasksLinks;
  Future<void> addTaskLinks(String value) async {
    _tasksLinks.add(value);
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

  // Method to show the dialog
  Future<void> addLinkDialog(BuildContext context) async {
    TextEditingController linkController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Link'),
            content: TextField(
              controller: linkController,
              decoration: InputDecoration(hintText: 'Enter link'),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: Text('Add'),
                  onPressed: () {
                    String link = linkController.text;
                    addTaskLinks(link).then((value) => Navigator.pop(context));
                  }),
            ],
          );
        });
  }

  // Function for createGoal
  void createGoal(BuildContext context) async {
    setLoading(true);
    try {
      setLoading(false);
    } catch (e) {
      setLoading(false);
      Utils.flushBarErrorMessage(e.toString(), context);
    }
  }
}
