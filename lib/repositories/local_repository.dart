import '../models/task_model.dart';

abstract class ILocalSavesRepository {
  Future<void> saveLocalTasks(List<Task> addedTownList);

  Future<List<Task>> loadLocalTasks();
}

class LocalSavesRepository implements ILocalSavesRepository {
  @override
  Future<List<Task>> loadLocalTasks() async {
    return [];
  }

  @override
  Future<void> saveLocalTasks(List<Task> addedTownList) async {
  }
}
