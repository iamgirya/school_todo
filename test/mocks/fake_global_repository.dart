import 'package:flutter_test/flutter_test.dart';
import 'package:school_todo/models/task_model.dart';
import 'package:school_todo/repositories/global_task_repository.dart';

class FakeGlobalRepository extends Fake implements IGlobalTaskSavesRepository {
  @override
  Future<Task?> deleteGlobalTask(String id) {
    return Future(() => null);
  }

  @override
  Future<Task?> getGlobalTask(String id) {
    return Future(() => null);
  }

  @override
  Future<List<Task>?> getGlobalTaskList() {
    return Future(() => null);
  }

  @override
  int getRevision() {
    return 0;
  }

  @override
  bool get isOffline => false;

  @override
  Future<List<Task>?> patchGlobalTaskList(List<Task> loadedTasks) {
    return Future(() => null);
  }

  @override
  Future<Task?> postGlobalTask(Task postTask) {
    return Future(() => null);
  }

  @override
  Future<Task?> putGlobalTask(String id, Task putTask) {
    return Future(() => null);
  }

}