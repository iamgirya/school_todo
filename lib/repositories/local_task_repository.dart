import '../models/task_model.dart';

abstract class ILocalTaskSavesRepository {
  Future<void> saveLocalTasks(List<Task> addedTownList);

  Future<List<Task>> loadLocalTasks();
}

class LocalTaskSavesRepository implements ILocalTaskSavesRepository {
  @override
  Future<List<Task>> loadLocalTasks() async {
    return [];
  }

  @override
  Future<void> saveLocalTasks(List<Task> addedTownList) async {}
}
