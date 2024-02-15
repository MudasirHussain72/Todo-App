class GoalsModel {
  String? goalTitle;
  String? goalDescription;
  bool? isCompleted;
  String? percentage;
  String? goalColor;
  List<TaskModel>? taskList;
  String? goalId;

  GoalsModel(
    this.goalTitle,
    this.isCompleted,
    this.percentage,
    this.goalColor,
    this.goalDescription,
    this.taskList,
    this.goalId,
  );

  GoalsModel.fromJson(Map<String, dynamic> json) {
    goalTitle = json['goalTitle'];
    goalDescription = json['goalDescription'];
    isCompleted = json['isCompleted'];
    percentage = json['percentage'];
    goalColor = json['goalColor'];
    goalId = json['goalId'];
    if (json['taskList'] != null) {
      taskList = <TaskModel>[];
      json['taskList'].forEach((v) {
        taskList!.add(TaskModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['goalTitle'] = goalTitle;
    data['goalDescription'] = goalDescription;
    data['isCompleted'] = isCompleted;
    data['percentage'] = percentage;
    data['goalColor'] = goalColor;
    data['goalId'] = goalId;
    if (taskList != null) {
      data['taskList'] = taskList!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  // Method to filter tasks by date and count completed tasks
  Map<String, int> calculateCompletedTasksCount(String currentDate) {
    int completedCount = 0;
    int totalCount = 0;

    for (var task in taskList!) {
      if (task.startDate == currentDate) {
        totalCount++;
        if (task.isCompleted!) {
          completedCount++;
        }
      }
    }

    return {'completed': completedCount, 'total': totalCount};
  }
}

class TaskModel {
  String? taskTitle;
  String? startDate;
  String? endDate;
  String? taskColor;
  String? goalType;
  String? goalName;
  String? goalDescription;
  bool? isCompleted;
  String? goalId;
  String? taskId;
  List<String>? links;

  TaskModel(
    this.taskTitle,
    this.taskColor,
    this.endDate,
    this.goalType,
    this.links,
    this.startDate,
    this.goalName,
    this.goalDescription,
    this.isCompleted,
    this.goalId,
    this.taskId,
  );

  TaskModel.fromJson(Map<String, dynamic> json) {
    taskTitle = json['taskTitle'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    taskColor = json['taskColor'];
    goalType = json['goalType'];
    goalName = json['goalName'];
    goalDescription = json['goalDescription'];
    isCompleted = json['isCompleted'];
    goalId = json['goalId'];
    taskId = json['taskId'];
    links = json['links']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taskTitle'] = taskTitle;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['taskColor'] = taskColor;
    data['goalType'] = goalType;
    data['goalName'] = goalName;
    data['goalDescription'] = goalDescription;
    data['isCompleted'] = isCompleted;
    data['links'] = links;
    data['goalId'] = goalId;
    data['taskId'] = taskId;
    return data;
  }
}
