class TaskModel {
  String title;
  String subTutle;
  bool isCompleted;
  DateTime createdAt;
  TaskModel({
    required this.title,
    required this.subTutle,
    required this.isCompleted,
    required this.createdAt, required String subTitle,
  });
}
