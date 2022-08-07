import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/core/container_class.dart';
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
  }

  final ILocalTaskSavesRepository localRepo;
  final IGlobalTaskSavesRepository globalRepo;
  final ICubitsConnectorRepository cubitsConnectorRepo;

  bool isCompletedVisible = false;

  List<Task> get loadedTasks => (state as TaskListHasData).loadedTasks;

  bool get _isStateHasData => state is TaskListHasData;

  void _changeState(
      {required Function changeCallBack, required bool isNeedToLocalSave}) {
    emit(TaskListWaitingChanges(loadedTasks: loadedTasks));
    changeCallBack();
    if (isNeedToLocalSave) {
      _saveTaskList();
    }
    emit(TaskListReady(loadedTasks: loadedTasks));
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

  void addNewFastTask(String text) {
    if (_isStateHasData) {
      _changeState(
        changeCallBack: () {
          Task fastTask = Task.empty();
          fastTask.text = text;
          loadedTasks.add(fastTask);
        },
        isNeedToLocalSave: false,
      );
    }
  }

  void deleteTask(Task toDeleteTask) {
    if (_isStateHasData) {
      _changeState(
        changeCallBack: () {
          loadedTasks.remove(toDeleteTask);
        },
        isNeedToLocalSave: false,
      );
    }
  }

  void changeCompletedTaskVisible() {
    if (_isStateHasData) {
      _changeState(
        changeCallBack: () {
          isCompletedVisible = !isCompletedVisible;
        },
        isNeedToLocalSave: false,
      );
    }
  }

  void changeTaskComplete(Task chosenTask) {
    if (_isStateHasData) {
      _changeState(
        changeCallBack: () {
          chosenTask.done = !chosenTask.done;
        },
        isNeedToLocalSave: true,
      );
    }
  }

  void onGetTaskFromEditor(Task data) {
    if (_isStateHasData) {
      emit(TaskListWaitingChanges(loadedTasks: loadedTasks));
      if (!loadedTasks.contains(data)) {
        loadedTasks.add(data);
      }
      emit(TaskListReady(loadedTasks: loadedTasks));
    }
  }

  void loadTaskList() async {
    List<Task> localTasks = localRepo.loadLocalTasks();
    // globalRepo.loadGlobalTasks();
    // localTasks.addAll(Cont.localTaskList);
    emit(TaskListReady(loadedTasks: localTasks));
  }

  void _saveTaskList() {
    if (_isStateHasData) {
      localRepo.saveLocalTasks(loadedTasks);
    }
  }
}
