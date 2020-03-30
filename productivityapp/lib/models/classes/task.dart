class Task {
  List<Task> tasks;
  String title;
  String note;
  DateTime timeToComplete;
  bool completed;
  String repeats;
  DateTime deadline;
  List<DateTime> reminders;
  String task_id;

  Task(this.title, this.completed, this.task_id);
}
