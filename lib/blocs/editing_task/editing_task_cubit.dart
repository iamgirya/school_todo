import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/core/container_class.dart';
import 'package:school_todo/generated/l10n.dart';
import 'package:school_todo/navigation/navigation_controller.dart';
import 'package:school_todo/repositories/cubits_connector_repository.dart';
import '../../core/logger.dart';
import '../../models/importance_model.dart';
import '../../models/task_model.dart';
import 'editing_task_state.dart';

class EditingTaskCubit extends Cubit<EditingTaskState> {
  EditingTaskCubit({Task? initTask, required this.cubitsConnectorRepo})
      : super(EditingTaskReady(editingTask: initTask ?? Task.empty())) {
    textController = TextEditingController();
    if (initTask != null) {
      textController.text = initTask.text;
      if (initTask.deadline != null) {
        switchValue = true;
      }
    }
  }

  final ICubitsConnectorRepository cubitsConnectorRepo;

  late TextEditingController textController;
  bool switchValue = false;

  bool get _stateIsHasData => state is EditingTaskHasData;

  int dateToUnix(DateTime date) => date.millisecondsSinceEpoch ~/ 1000;

  Task get taskModel => (state as EditingTaskHasData).editingTask;

  Future<void> _selectDeadLine(BuildContext context) async {
    int? nowUnixDeadline = taskModel.deadline;
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030));
    if (picked != null) {
      int pickedUnix = dateToUnix(picked);
      if (pickedUnix != nowUnixDeadline) {
        taskModel.deadline = pickedUnix;
      }
    } else if (nowUnixDeadline == null) {
      switchValue = false;
    }
  }

  void onTapeOnDate(BuildContext context) async {
    if (_stateIsHasData) {
      if (taskModel.deadline != null && switchValue) {
        emit(EditingTaskWaitingChanges(editingTask: taskModel));
        await _selectDeadLine(context);
        emit(EditingTaskReady(editingTask: taskModel));
      }
    }
  }

  void changeSwitch(BuildContext context) async {
    if (_stateIsHasData) {
      switchValue = !switchValue;
      emit(EditingTaskWaitingChanges(editingTask: taskModel));
      if (switchValue && taskModel.deadline == null) {
        await _selectDeadLine(context);
      }
      emit(EditingTaskReady(editingTask: taskModel));
    }
  }

  void changeImportance(Importance? importance) {
    if (importance != null && _stateIsHasData) {
      emit(EditingTaskWaitingChanges(editingTask: taskModel));
      taskModel.importance = importance;
      emit(EditingTaskReady(editingTask: taskModel));
    }
  }

  void deleteTask(BuildContext context) {
    if (_stateIsHasData) {
      cubitsConnectorRepo.deleteTask(taskModel);
    }
    context.read<NavigationController>().pop();
  }

  void saveTask(BuildContext context) {
    if (_stateIsHasData) {
      taskModel.text = textController.text;
      taskModel.changedAt = dateToUnix(DateTime.now());
      taskModel.lastUpdatedBy = Cont.getDeviceId;

      cubitsConnectorRepo.addNewTask(taskModel);
    }

    context.read<NavigationController>().pop();
  }
}
