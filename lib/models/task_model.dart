class TaskModel {
  String title;
  bool isCompleted;

  TaskModel({
    required this.title,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'isCompleted': isCompleted,
      };
}
