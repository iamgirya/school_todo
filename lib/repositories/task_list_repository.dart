import 'package:school_todo/repositories/global_task_repository.dart';
import 'package:school_todo/repositories/local_task_repository.dart';

import '../core/logger.dart';
import '../models/animated_task_model.dart';
import '../models/task_model.dart';

abstract class ITaskSavesRepository {
  final ILocalTaskSavesRepository localRepo;
  final IGlobalTaskSavesRepository globalRepo;

  ITaskSavesRepository({required this.localRepo, required this.globalRepo});

  Future<void> postChanges(
      List<AnimatedTask> newLoadedTasks, AnimatedTask postTask);
  Future<void> putChanges(List<AnimatedTask> newLoadedTasks,
      String changedTaskId, AnimatedTask putTask);
  Future<void> deleteChanges(
      List<AnimatedTask> newLoadedTasks, String deleteTaskId);
  Future<void> patchChanges(List<AnimatedTask> newLoadedTasks);

  Future<List<Task>> loadActualTaskList();
}

class TaskListRepository implements ITaskSavesRepository {
  TaskListRepository({required this.localRepo, required this.globalRepo});

  @override
  IGlobalTaskSavesRepository globalRepo;

  @override
  ILocalTaskSavesRepository localRepo;

  @override
  Future<void> postChanges(
      List<AnimatedTask> newLoadedTasks, AnimatedTask postTask) async {
    List<Task> saveTaskList = newLoadedTasks.map((e) => e.task).toList();
    localRepo.saveLocalTasks(saveTaskList);

    bool isConnected = globalRepo.isOffline;
    await globalRepo.postGlobalTask(postTask.task);
    localRepo.saveLocalRevision(globalRepo.getRevision());
    if (isConnected && !globalRepo.isOffline) {
      globalRepo.patchGlobalTaskList(localRepo.loadLocalTasks());
    }
  }

  @override
  Future<void> deleteChanges(
      List<AnimatedTask> newLoadedTasks, String deleteTaskId) async {
    List<Task> saveTaskList = newLoadedTasks.map((e) => e.task).toList();
    localRepo.saveLocalTasks(saveTaskList);

    bool isConnected = globalRepo.isOffline;
    await globalRepo.deleteGlobalTask(deleteTaskId);
    localRepo.saveLocalRevision(globalRepo.getRevision());
    if (isConnected && !globalRepo.isOffline) {
      globalRepo.patchGlobalTaskList(localRepo.loadLocalTasks());
    }
  }

  @override
  Future<void> putChanges(List<AnimatedTask> newLoadedTasks,
      String changedTaskId, AnimatedTask putTask) async {
    List<Task> saveTaskList = newLoadedTasks.map((e) => e.task).toList();
    localRepo.saveLocalTasks(saveTaskList);

    bool isConnected = globalRepo.isOffline;
    await globalRepo.putGlobalTask(changedTaskId, putTask.task);
    localRepo.saveLocalRevision(globalRepo.getRevision());
    if (isConnected && !globalRepo.isOffline) {
      globalRepo.patchGlobalTaskList(localRepo.loadLocalTasks());
    }
  }

  @override
  Future<List<Task>> loadActualTaskList() async {
    List<Task> localTasks;
    List<Task>? globalTasks;

    localTasks = localRepo.loadLocalTasks();
    globalTasks = await globalRepo.getGlobalTaskList();
    if (globalTasks != null) {
      int localRevision = localRepo.loadLocalRevision();
      int globalRevision = globalRepo.getRevision();

      if (localRevision < globalRevision) {
        logger.info('Global data is main');
        localRepo.saveLocalRevision(globalRevision);
        localRepo.saveLocalTasks(globalTasks);
        localTasks = globalTasks;
      } else {
        logger.info('Local data is main');
        globalRepo.patchGlobalTaskList(localTasks);
      }
    }
    return localTasks;
  }

  @override
  Future<void> patchChanges(List<AnimatedTask> newLoadedTasks) async {
    List<Task> saveTaskList = newLoadedTasks.map((e) => e.task).toList();
    localRepo.saveLocalTasks(saveTaskList);

    bool isConnected = globalRepo.isOffline;
    await globalRepo.patchGlobalTaskList(saveTaskList);
    localRepo.saveLocalRevision(globalRepo.getRevision());
    if (isConnected && !globalRepo.isOffline) {
      globalRepo.patchGlobalTaskList(localRepo.loadLocalTasks());
    }
  }
}
