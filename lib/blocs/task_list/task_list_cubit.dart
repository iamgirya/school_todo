import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/core/logger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/container_class.dart';
import '../../core/device_id_holder.dart';
import '../../models/task_model.dart';
import '../../repositories/local_task_repository.dart';

import '../../repositories/cubits_connector_repository.dart';
import '../../repositories/global_task_repository.dart';

part 'task_list_state.dart';
part 'task_list_cubit.freezed.dart';

class TaskListCubit extends Cubit<TaskListState> {
  TaskListCubit(
      {required this.localRepo,
        required this.globalRepo,
        required this.cubitsConnectorRepo})
      : super(const TaskListState.initial()) {
    cubitsConnectorRepo.setCallBackOnNewTask(onGetTaskFromEditor);
    cubitsConnectorRepo.setCallBackOnDeleteTask(deleteTask);
  }

  final ILocalTaskSavesRepository localRepo;
  final IGlobalTaskSavesRepository globalRepo;
  final ICubitsConnectorRepository cubitsConnectorRepo;
  bool get isOfflineMode => globalRepo.isOffline;

  List<Task> get loadedTasks => (state as TaskListLoadedState).loadedTasks;
  bool get isCompletedVisible => (state as TaskListLoadedState).isCompletedVisible;

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
    if (state is TaskListLoadedState) {
      return loadedTasks.length;
    }
    return 0;
  }

  int getUnLengthOfCompletedTaskList() {
    if (state is TaskListLoadedState) {
      return loadedTasks.where((element) => !element.done).length;
    }
    return 0;
  }

  Task getTask(int index) {
    if (state is TaskListLoadedState) {
      return loadedTasks[index];
    } else {
      throw Error();
    }
  }

  Task getUnCompletedTask(int index) {
    if (state is TaskListLoadedState) {
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

  void addNewFastTask(TextEditingController fastTaskTextEditingController) {
    if (state is TaskListLoadedState && fastTaskTextEditingController.text.isNotEmpty) {
      Task fastTask = Task.empty(fastTaskTextEditingController.text, deviceId: Cont.getIt.get<DeviceIdHolder>().getDeviceId);
      fastTaskTextEditingController.clear();
      logger.info(
          'Add fast task with text: ${fastTaskTextEditingController.text}');
      List<Task> newLoadedTasks = List<Task>.from(loadedTasks)..add(fastTask);

      localRepo.saveLocalTasks(loadedTasks);
      if (!isOfflineMode) {
        globalRepo.postGlobalTask(fastTask);
      }
      AppMetrica.reportEvent('Add new fast task');
      emit(TaskListState.loaded(loadedTasks: newLoadedTasks, isCompletedVisible: isCompletedVisible));
    }
  }

  void deleteTask(Task toDeleteTask) {
    if (state is TaskListLoadedState) {
      int indexOfDeletingTask = loadedTasks.indexWhere((element) => element.id == toDeleteTask.id);
      List<Task> newLoadedTasks = List<Task>.from(loadedTasks)..removeAt(indexOfDeletingTask);

      localRepo.saveLocalTasks(loadedTasks);
      if (!isOfflineMode) {
        globalRepo.deleteGlobalTask(toDeleteTask.id);
      }
      AppMetrica.reportEvent('Delete task');

      emit(TaskListState.loaded(loadedTasks: newLoadedTasks, isCompletedVisible: isCompletedVisible));
    }
  }

  void changeCompletedTaskVisible() {
    if (state is TaskListLoadedState) {
      emit(TaskListState.loaded(loadedTasks: loadedTasks, isCompletedVisible: !isCompletedVisible));
      logger.info(
          'Change completed task visible to $isCompletedVisible');
    }
  }

  void changeTaskComplete(Task chosenTask) {
    if (state is TaskListLoadedState) {
      chosenTask = chosenTask.copyWith(done: !chosenTask.done);
      int indexOfEditedTask = loadedTasks.indexWhere((element) => element.id == chosenTask.id);

      List<Task> newLoadedTasks = List<Task>.from(loadedTasks);
      newLoadedTasks[indexOfEditedTask] = chosenTask;

      localRepo.saveLocalTasks(loadedTasks);
      if (!isOfflineMode) {
        globalRepo.putGlobalTask(chosenTask.id, chosenTask);
      }
      if (chosenTask.done) {
        AppMetrica.reportEvent('Task complete');
      } else {
        AppMetrica.reportEvent('Task incomplete');
      }
      logger.info(
          'Change task with index ${chosenTask.id} complete to: ${chosenTask.done}');
      emit(TaskListState.loaded(loadedTasks: newLoadedTasks, isCompletedVisible: isCompletedVisible));
    }
  }

  void onGetTaskFromEditor(Task editingTask) {
    if (state is TaskListLoadedState) {
      int indexOfEditedTask = loadedTasks.indexWhere((element) => element.id == editingTask.id);
      List<Task> newLoadedTasks;
      if (indexOfEditedTask == -1) {
        newLoadedTasks = List<Task>.from(loadedTasks)..add(editingTask);

        localRepo.saveLocalTasks(loadedTasks);
        if (!isOfflineMode) {
          globalRepo.postGlobalTask(editingTask);
        }
        AppMetrica.reportEvent('Add new editing task');
      } else {
        newLoadedTasks = List<Task>.from(loadedTasks);
        newLoadedTasks[indexOfEditedTask] = editingTask;

        localRepo.saveLocalTasks(loadedTasks);
        if (!isOfflineMode) {
          globalRepo.putGlobalTask(editingTask.id, editingTask);
        }
      }
      emit(TaskListState.loaded(loadedTasks: newLoadedTasks, isCompletedVisible: isCompletedVisible));
    }
  }

  Future<void> initialLoadTaskList() async {
    if (isOfflineMode) {
      List<Task> localTasks = localRepo.loadLocalTasks();
      emit(TaskListState.loaded(loadedTasks: localTasks, isCompletedVisible: false));
    } else {
      List<Task> localTasks = localRepo.loadLocalTasks();
      List<Task>? globalTasks = await globalRepo.getGlobalTaskList();
      if (!isClosed) {
        if (globalTasks == null) {
          emit(const TaskListState.error(message: ''));
        } else {
          localTasks = await _checkLocalChanges(localTasks, globalTasks);
          emit(TaskListState.loaded(loadedTasks: localTasks, isCompletedVisible: false));
        }
      }
    }
  }
}
