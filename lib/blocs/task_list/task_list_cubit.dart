import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/core/container_class.dart';
import 'package:school_todo/navigation/navigation_controller.dart';
import 'package:school_todo/repositories/cubits_connectror_repository.dart';
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
    cubitsConnectorRepo.setCallBackOnNewTask(addNewTask);
    cubitsConnectorRepo.setCallBackOnDeleteTask(deleteTask);
  }

  final ILocalTaskSavesRepository localRepo;
  final IGlobalTaskSavesRepository globalRepo;
  final ICubitsConnectorRepository cubitsConnectorRepo;

  bool isCompletedVisible = false;

  List<Task> get loadedTasks => (state as TaskListHasData).loadedTasks;

  bool get _isStateHasData => state is TaskListHasData;

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
      var l = loadedTasks.where((element) => !element.done).toList();
      return l[index];
    } else {
      throw Error();
    }
  }

  void addNewTask(Task data) {
    if (_isStateHasData) {
      emit(TaskListWaitingChanges(loadedTasks: loadedTasks));
      if (!loadedTasks.contains(data)) {
        loadedTasks.add(data);
      }
      emit(TaskListReady(loadedTasks: loadedTasks));
    }
  }

  void addNewFastTask(String text) {
    if (_isStateHasData) {
      emit(TaskListWaitingChanges(loadedTasks: loadedTasks));
      Task fastTask = Task.empty();
      fastTask.text = text;
      loadedTasks.add(fastTask);
      emit(TaskListReady(loadedTasks: loadedTasks));
    }
  }

  void deleteTask(Task toDeleteTask) {
    if (_isStateHasData) {
      emit(TaskListWaitingChanges(loadedTasks: loadedTasks));
      loadedTasks.remove(toDeleteTask);
      emit(TaskListReady(loadedTasks: loadedTasks));
    }
  }

  void changeCompletedTaskVisible() {
    if (_isStateHasData) {
      isCompletedVisible = !isCompletedVisible;
      emit(TaskListWaitingChanges(loadedTasks: loadedTasks));
      emit(TaskListReady(loadedTasks: loadedTasks));
    }
  }

  void changeTaskComplete(Task chosenTask) {
    if (_isStateHasData) {
      emit(TaskListWaitingChanges(loadedTasks: loadedTasks));
      chosenTask.done = !chosenTask.done;
      emit(TaskListReady(loadedTasks: loadedTasks));
    }
  }

  void loadTaskList() {
    //загрузка из глобала и из локала
    List<Task> tmp = [];
    tmp.addAll(Cont.localTaskList);
    emit(TaskListReady(loadedTasks: tmp));
  }
}
