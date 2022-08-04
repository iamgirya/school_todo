import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/core/container_class.dart';
import 'package:school_todo/navigation/navigation_controller.dart';
import '../../models/task_model.dart';
import 'task_list_state.dart';

class TaskListCubit extends Cubit<TaskListState> {
  TaskListCubit()
      : super(TaskListOnStart());

  void addNewTown(Task data) async {
    if (state is TaskListLoaded) {
      List<Task> loadedTasks = (state as TaskListLoaded).loadedTasks;
      loadedTasks.add(data);
      emit(TaskListLoading());
      emit(TaskListLoaded(loadedTasks: loadedTasks));
    }
  }

  int getLengthOfTaskList() {
    if (state is TaskListLoaded) {
      return (state as TaskListLoaded).loadedTasks.length;
    }
    return 0;
  }

  Task getTask(int index) {
    try {
      if (state is TaskListLoaded) {
        return (state as TaskListLoaded).loadedTasks[index];
      }
      throw Error();
    } catch (e) {
      rethrow;
    }
  }

  void deleteTask(int index) {
    if (state is TaskListLoaded) {
      List<Task> loadedTasks = (state as TaskListLoaded).loadedTasks;
      loadedTasks.removeAt(index);
      emit(TaskListLoading());
      emit(TaskListLoaded(loadedTasks: loadedTasks));
    }
  }

  void loadTaskList() {
    //загрузка из глобала и из локала
    List<Task> tmp = [];
    tmp.addAll(Cont.localTaskList);
    emit(TaskListLoaded(loadedTasks: tmp));
  }

}
