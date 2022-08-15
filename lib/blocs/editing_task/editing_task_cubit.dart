import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/navigation/navigation_controller.dart';
import 'package:school_todo/repositories/cubits_connector_repository.dart';
import '../../core/container_class.dart';
import '../../core/device_id_holder.dart';
import '../../core/logger.dart';
import '../../models/importance_model.dart';
import '../../models/task_model.dart';
import 'editing_task_state.dart';

class EditingTaskCubit extends Cubit<EditingTaskState> {
  EditingTaskCubit({Task? initTask, required this.cubitsConnectorRepo})
      : super(EditingTaskReady(editingTask: initTask ?? Task.empty('', deviceId: Cont.getIt.get<DeviceIdHolder>().getDeviceId))) {
    if (initTask != null) {
      if (initTask.deadline != null) {
        switchValue = true;
      }
    }
  }

  final ICubitsConnectorRepository cubitsConnectorRepo;

  bool switchValue = false;
  bool taskCanBeDeleted = false;

  bool get _stateIsHasData => state is EditingTaskHasData;

  int dateToUnix(DateTime date) => date.millisecondsSinceEpoch ~/ 1000;

  Task get taskModel => (state as EditingTaskHasData).editingTask;
  set taskModel (Task value) {
    emit(EditingTaskReady(editingTask: value));
  }

  void onStartOrEndInput(String? text) {
    if (text != null && (!taskCanBeDeleted && text.isNotEmpty || taskCanBeDeleted && text.isEmpty)) {
      taskCanBeDeleted = !taskCanBeDeleted;
      if (_stateIsHasData) {
        emit(EditingTaskWaitingChanges(editingTask: taskModel));
        emit(EditingTaskReady(editingTask: taskModel));
      }
    }
  }

  Future<void> _selectDeadLine(BuildContext context) async {
    int? nowUnixDeadline = taskModel.deadline;
    final DateTime? picked = await showDatePicker(
        helpText: '',
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030));
    if (picked != null) {
      int pickedUnix = dateToUnix(picked);
      if (pickedUnix != nowUnixDeadline) {
        taskModel = taskModel.copyWith(deadline: pickedUnix);
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
      taskModel = taskModel.copyWith(importance: importance);
    }
  }

  void deleteTask(BuildContext context) {
    if (_stateIsHasData) {
      logger.info('Delete task');
      cubitsConnectorRepo.deleteTask(taskModel);
    }
    context.read<NavigationController>().pop();
  }

  void saveTask(BuildContext context, String text) {
    if (_stateIsHasData) {
      Task savedTaskModel = taskModel.copyWith(
          text: text,
          changedAt: dateToUnix(DateTime.now()),
          lastUpdatedBy: Cont.getIt.get<DeviceIdHolder>().getDeviceId,
      );

      cubitsConnectorRepo.addNewTask(savedTaskModel);
      logger.info('Save task');
    }

    context.read<NavigationController>().pop();
  }
}
