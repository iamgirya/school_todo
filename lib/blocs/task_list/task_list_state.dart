import 'package:flutter/material.dart';
import '../../models/task_model.dart';

@immutable
abstract class TaskListState {}

class TaskListError extends TaskListState {
  final String message;

  TaskListError({required this.message});
}

class TaskListOnStart extends TaskListState {}

class TaskListHasData extends TaskListState {
  final List<Task> loadedTasks;

  TaskListHasData({required this.loadedTasks});
}

class TaskListWaitingChanges extends TaskListHasData {
  TaskListWaitingChanges({required super.loadedTasks});
}

class TaskListReady extends TaskListHasData {
  TaskListReady({required super.loadedTasks});
}
