import 'package:school_todo/models/task_model.dart';

class AnimatedTask {
  AnimatedTask(
      {required this.task,
      required this.isAnimated,
      required this.isNeedToBeVisible});

  final Task task;
  final bool isAnimated;
  final bool isNeedToBeVisible;

  AnimatedTask copyWith(
      {Task? task, bool? isAnimated, bool? isNeedToBeVisible}) {
    return AnimatedTask(
        task: task ?? this.task,
        isAnimated: isAnimated ?? this.isAnimated,
        isNeedToBeVisible: isNeedToBeVisible ?? this.isNeedToBeVisible);
  }
}
