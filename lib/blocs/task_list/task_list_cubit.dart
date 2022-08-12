import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/core/logger.dart';
import 'package:school_todo/repositories/cubits_connector_repository.dart';
import 'package:school_todo/repositories/global_task_repository.dart';
import '../../models/task_model.dart';
import '../../repositories/local_task_repository.dart';
import 'task_list_state.dart';

class TaskListCubit extends Cubit<TaskListState> {
  TaskListCubit(
      {required this.localRepo,
      required this.globalRepo,
      required this.cubitsConnectorRepo})
      : super(TaskListOnStart()) {
    cubitsConnectorRepo.setCallBackOnNewTask(onGetTaskFromEditor);
    cubitsConnectorRepo.setCallBackOnDeleteTask(deleteTask);
    fastTaskTextEditingController = TextEditingController();
  }

  late TextEditingController fastTaskTextEditingController;

  final ILocalTaskSavesRepository localRepo;
  final IGlobalTaskSavesRepository globalRepo;
  final ICubitsConnectorRepository cubitsConnectorRepo;

  bool isCompletedVisible = false;

  bool get isOfflineMode => globalRepo.isOffline;

  List<Task> get loadedTasks => (state as TaskListHasData).loadedTasks;

  bool get _isStateHasData => state is TaskListHasData;

  TextEditingController get getFastTaskTextEditingController => fastTaskTextEditingController;

  void _changeState({required Function changeCallBack}) {
    emit(TaskListWaitingChanges(loadedTasks: loadedTasks));
    changeCallBack();
    emit(TaskListReady(loadedTasks: loadedTasks));
  }

  Future<List<Task>> _checkLocalChanges(
      List<Task> localTasks, List<Task> globalTasks) async {
    bool localChanges = localTasks.length != globalTasks.length;
    if (!localChanges) {
      for (int i = 0; i < localTasks.length; i++) {
        if (!globalTasks.contains(localTasks[i])) {
          localChanges = true;
          break;
        }
      }
    }
    logger.info(localChanges ? 'need to patch data' : 'similar data');

    if (!isOfflineMode) {
      if (localChanges) {
        List<Task>? patchedGlobalTasks =
        await globalRepo.patchGlobalTaskList(localTasks);
        if (patchedGlobalTasks != null) {
          localRepo.saveLocalTasks(patchedGlobalTasks);
          return patchedGlobalTasks;
        }
      }
    }
    return localTasks;
  }

  int getLengthOfTaskList() {
    if (_isStateHasData) {
      return loadedTasks.length;
    }
    return 0;
  }

  int getUnLengthOfCompletedTaskList() {
    if (_isStateHasData) {
      return loadedTasks.where((element) => !element.done).length;
    }
    return 0;
  }

  Task getTask(int index) {
    if (_isStateHasData) {
      return loadedTasks[index];
    } else {
      throw Error();
    }
  }

  Task getUnCompletedTask(int index) {
    if (_isStateHasData) {
      int unCompletedIndex = -1;
      for (int i = 0; i < loadedTasks.length; i++) {
        if (!loadedTasks[i].done) {
          unCompletedIndex++;
          if (unCompletedIndex == index) {
            return loadedTasks[i];
          }
        }
      }
      throw Error();
    } else {
      throw Error();
    }
  }

  void addNewFastTask([String? text]) {
    if (_isStateHasData) {
      _changeState(
        changeCallBack: () {
          Task fastTask;

          if (text == null) {
            fastTask = Task.empty(getFastTaskTextEditingController.text);
            getFastTaskTextEditingController.clear();
            logger.info(
                "Add fast task with text: ${getFastTaskTextEditingController.text}");
          } else {
            fastTask = Task.empty(text);
          }

          loadedTasks.add(fastTask);

          localRepo.saveLocalTasks(loadedTasks);
          if (!isOfflineMode) {
            globalRepo.postGlobalTask(fastTask);
          }
          AppMetrica.reportEvent("Add new fast task");
        },
      );
    }
  }

  void deleteTask(Task toDeleteTask) {
    if (_isStateHasData) {
      _changeState(
        changeCallBack: () {
          loadedTasks.remove(toDeleteTask);

          localRepo.saveLocalTasks(loadedTasks);
          if (!isOfflineMode) {
            globalRepo.deleteGlobalTask(toDeleteTask.id);
          }
          AppMetrica.reportEvent("Delete task");
        },
      );
    }
  }

  void changeCompletedTaskVisible() {
    if (_isStateHasData) {
      _changeState(
        changeCallBack: () {
          isCompletedVisible = !isCompletedVisible;
        },
      );
    }
  }

  void changeTaskComplete(Task chosenTask) {
    if (_isStateHasData) {
      _changeState(
        changeCallBack: () {
          chosenTask = chosenTask.copyWith(done: !chosenTask.done);
          int indexOfEditedTask = loadedTasks.indexWhere((element) => element.id == chosenTask.id);
          loadedTasks[indexOfEditedTask] = chosenTask;

          localRepo.saveLocalTasks(loadedTasks);
          if (!isOfflineMode) {
            globalRepo.putGlobalTask(chosenTask.id, chosenTask);
          }
          if (chosenTask.done) {
            AppMetrica.reportEvent("Task complete");
          } else {
            AppMetrica.reportEvent("Task incomplete");
          }
        },
      );
    }
  }

  void onGetTaskFromEditor(Task editingTask) {
    if (_isStateHasData) {
      _changeState(
        changeCallBack: () {
          int indexOfEditedTask = loadedTasks.indexWhere((element) => element.id == editingTask.id);
          if (indexOfEditedTask == -1) {
            loadedTasks.add(editingTask);

            localRepo.saveLocalTasks(loadedTasks);
            if (!isOfflineMode) {
              globalRepo.postGlobalTask(editingTask);
            }
            AppMetrica.reportEvent("Add new editing task");
          } else {
            loadedTasks[indexOfEditedTask] = editingTask;
            localRepo.saveLocalTasks(loadedTasks);
            if (!isOfflineMode) {
              globalRepo.putGlobalTask(editingTask.id, editingTask);
            }
          }
        },
      );
    }
  }

  Future<void> loadTaskList() async {
    if (isOfflineMode) {
      List<Task> localTasks = localRepo.loadLocalTasks();
      emit(TaskListReady(loadedTasks: localTasks));
    } else {
      List<Task> localTasks = localRepo.loadLocalTasks();
      List<Task>? globalTasks = await globalRepo.getGlobalTaskList();
      if (!isClosed) {
        if (globalTasks == null) {
          emit(TaskListLoadError());
        } else {
          localTasks = await _checkLocalChanges(localTasks, globalTasks);
          emit(TaskListReady(loadedTasks: localTasks));
        }
      }
    }
  }
}
