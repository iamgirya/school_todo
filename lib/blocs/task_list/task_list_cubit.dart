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

  List<Task> get loadedTasks => (state as TaskListLoadedState).loadedTasks;
  bool get isCompletedVisible => (state as TaskListLoadedState).isCompletedVisible;

  Future<void> _doServerRequest(Future<void> Function() serverRequest) async {
    bool isConnected = globalRepo.isOffline;
    await serverRequest();
    localRepo.saveLocalRevision(globalRepo.getRevision());
    if (isConnected && !globalRepo.isOffline) {
      globalRepo.patchGlobalTaskList(localRepo.loadLocalTasks());
    }
  }

  List<Task> _checkLocalChanges(List<Task> localTasks, List<Task> globalTasks)  {
    int localRevision = localRepo.loadLocalRevision();
    int globalRevision = globalRepo.getRevision();

    if (localRevision < globalRevision) {
      logger.info('Global data is main');
      localRepo.saveLocalRevision(globalRevision);
      localRepo.saveLocalTasks(globalTasks);
      return globalTasks;
    } else {
      logger.info('Local data is main');
      globalRepo.patchGlobalTaskList(localTasks);
      return localTasks;
    }
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
      logger.info(
          'Add fast task with text: ${fastTaskTextEditingController.text}');
      fastTaskTextEditingController.clear();
      List<Task> newLoadedTasks = List<Task>.from(loadedTasks)..add(fastTask);

      localRepo.saveLocalTasks(newLoadedTasks);
      _doServerRequest(
        () async {
          await globalRepo.postGlobalTask(fastTask);
        }
      );

      AppMetrica.reportEvent('Add new fast task');

      emit(TaskListState.loaded(loadedTasks: newLoadedTasks, isCompletedVisible: isCompletedVisible));
    }
  }

  void deleteTask(Task toDeleteTask) {
    if (state is TaskListLoadedState) {
      int indexOfDeletingTask = loadedTasks.indexWhere((element) => element.id == toDeleteTask.id);
      List<Task> newLoadedTasks = List<Task>.from(loadedTasks)..removeAt(indexOfDeletingTask);

      localRepo.saveLocalTasks(newLoadedTasks);
      _doServerRequest(
              () async {
            await globalRepo.deleteGlobalTask(toDeleteTask.id);
          }
      );

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

      localRepo.saveLocalTasks(newLoadedTasks);
      _doServerRequest(
              () async {
            await globalRepo.putGlobalTask(chosenTask.id, chosenTask);
          }
      );

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

        localRepo.saveLocalTasks(newLoadedTasks);
        _doServerRequest(
                () async {
              await globalRepo.postGlobalTask(editingTask);
            }
        );
        AppMetrica.reportEvent('Add new editing task');
      } else {
        newLoadedTasks = List<Task>.from(loadedTasks);
        newLoadedTasks[indexOfEditedTask] = editingTask;

        localRepo.saveLocalTasks(newLoadedTasks);
        _doServerRequest(
                () async {
              await globalRepo.putGlobalTask(editingTask.id, editingTask);
            }
        );
      }
      emit(TaskListState.loaded(loadedTasks: newLoadedTasks, isCompletedVisible: isCompletedVisible));
    }
  }

  Future<void> initialLoadTaskList() async {
    List<Task> localTasks;
    List<Task>? globalTasks;

    localTasks = localRepo.loadLocalTasks();
    globalTasks = await globalRepo.getGlobalTaskList();
    if (globalTasks != null) {
      localTasks = _checkLocalChanges(localTasks, globalTasks);
    }

    emit(TaskListState.loaded(loadedTasks: localTasks, isCompletedVisible: false));
  }
}
