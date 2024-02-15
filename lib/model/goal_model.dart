class GoalsModel {
  String? goalTitle;
  String? goalDescription;
  bool? isCompleted;
  String? percentage;
  String? goalColor;
  List<TaskModel>? taskList;

  GoalsModel(
    this.goalTitle,
    this.isCompleted,
    this.percentage,
    this.goalColor,
    this.goalDescription,
    this.taskList,
  );

  GoalsModel.fromJson(Map<String, dynamic> json) {
    goalTitle = json['goalTitle'];
    goalDescription = json['goalDescription'];
    isCompleted = json['isCompleted'];
    percentage = json['percentage'];
    goalColor = json['goalColor'];
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
    if (taskList != null) {
      data['taskList'] = taskList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskModel {
  String? taskTitle;
  String? startDate;
  String? endDate;
  String? taskColor;
  String? goalType;
  List<String>? links;

  TaskModel(
    this.taskTitle,
    this.taskColor,
    this.endDate,
    this.goalType,
    this.links,
    this.startDate,
  );

  TaskModel.fromJson(Map<String, dynamic> json) {
    taskTitle = json['taskTitle'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    taskColor = json['taskColor'];
    goalType = json['goalType'];
    links = json['links']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taskTitle'] = taskTitle;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['taskColor'] = taskColor;
    data['goalType'] = goalType;
    data['links'] = links;
    return data;
  }
}
