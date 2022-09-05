import 'package:flutter_test/flutter_test.dart';
import 'package:school_todo/models/animated_task_model.dart';
import 'package:school_todo/models/task_model.dart';
import 'package:school_todo/repositories/task_list_repository.dart';

class FakeTaskSavesRepository extends Fake implements TaskSavesRepository {
  @override
  Future<bool> deleteChanges(
      List<AnimatedTask> newLoadedTasks, String deleteTaskId) {
    return Future(() => false);
  }

  @override
  bool get isOffline => false;

  @override
  Future<List<Task>> loadActualTaskList() {
    return Future(() => []);
  }

  @override
  Map<String, bool> loadConfiguration() {
    return {'isTaskSorting': false};
  }

  @override
  Future<bool> postChanges(
      List<AnimatedTask> newLoadedTasks, AnimatedTask postTask) {
    return Future(() => false);
  }

  @override
  Future<bool> putChanges(List<AnimatedTask> newLoadedTasks,
      String changedTaskId, AnimatedTask putTask) {
    return Future(() => false);
  }

  @override
  void saveConfiguration({required bool isTaskSorting}) {}
}
