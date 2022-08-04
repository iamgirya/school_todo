import 'package:flutter/material.dart';
import '../../models/task_model.dart';


@immutable
abstract class TaskListState {
}

class TaskListError extends TaskListState {
  final String message;

  TaskListError({required this.message});
}

class TaskListLoading extends TaskListState {}

class TaskListOnStart extends TaskListState {}

class TaskListLoaded extends TaskListState {
  final List<Task> loadedTasks;

  TaskListLoaded({required this.loadedTasks});
}
