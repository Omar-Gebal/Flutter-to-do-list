class Todo {
  final int id;
  final int taskId;
  final String title;
  final int finished;
  Todo({this.id, this.taskId, this.title, this.finished});
  Map<String, dynamic> toMap() {
    return {'id': id, 'taskId': taskId, 'title': title, 'finished': finished};
  }
}
