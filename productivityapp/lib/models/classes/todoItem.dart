class Task {
  List<Task> tasks;
  String title;
  String note;
  DateTime timeToComplete;
  bool completed;
  String repeats;
  DateTime deadline;
  List<DateTime> reminders;
  String taskId;

  Task({this.title, this.completed});
}
