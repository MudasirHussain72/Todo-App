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
}
