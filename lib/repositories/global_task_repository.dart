import '../models/task_model.dart';

abstract class IGlobalTaskSavesRepository {
  Future<void> saveGlobalTasks(List<Task> addedTownList);

  Future<List<Task>> loadGlobalTasks();
}

class GlobalTaskSavesRepository implements IGlobalTaskSavesRepository {
  @override
  Future<List<Task>> loadGlobalTasks() async {
    return [];
  }

  @override
  Future<void> saveGlobalTasks(List<Task> addedTownList) async {}
}
