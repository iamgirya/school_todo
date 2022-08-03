import 'package:flutter/material.dart';
import '../models/task_model.dart';
import 'package:equatable/equatable.dart';


@immutable
abstract class EditingTaskState  {
}

class EditingTaskError extends EditingTaskState {
  final String message;

  @override
  List<String> get props => [message];

  EditingTaskError({required this.message});
}

class EditingTaskHasData extends EditingTaskState {
  final Task editingTask;

  EditingTaskHasData({required this.editingTask});
}

class EditingTaskWaitingChanges extends EditingTaskHasData {

  EditingTaskWaitingChanges({required editingTask}) : super(editingTask: editingTask);
}

class EditingTaskReady extends EditingTaskHasData {

  EditingTaskReady({required editingTask}) : super(editingTask: editingTask);
}