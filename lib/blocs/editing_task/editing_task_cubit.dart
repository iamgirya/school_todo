import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/navigation/navigation_controller.dart';
import 'package:school_todo/repositories/cubits_connector_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/container_class.dart';
import '../../core/device_id_holder.dart';
import '../../core/logger.dart';
import '../../models/importance_model.dart';
import '../../models/task_model.dart';
import '../../navigation/delegate.dart';

part 'editing_task_state.dart';
part 'editing_task_cubit.freezed.dart';

class EditingTaskCubit extends Cubit<EditingTaskState> {
  EditingTaskCubit({Task? initTask, required this.cubitsConnectorRepo})
      : super(EditingTaskState.loaded(
          editingTask: initTask ?? Task.empty(''),
          switchValue: initTask != null && initTask.deadline != null,
          taskCanBeDeleted: initTask != null,
        ));

  final ICubitsConnectorRepository cubitsConnectorRepo;

  bool get _stateIsLoaded => state is EditingTaskLoadedState;
  Task get editingTask => (state as EditingTaskLoadedState).editingTask;
  bool get switchValue => (state as EditingTaskLoadedState).switchValue;
  bool get taskCanBeDeleted =>
      (state as EditingTaskLoadedState).taskCanBeDeleted;

  int _dateToUnix(DateTime date) => date.millisecondsSinceEpoch ~/ 1000;

  Future<int?> _selectDeadLine(BuildContext context) async {
    int? nowUnixDeadline = editingTask.deadline;
    final DateTime? picked = await showDatePicker(
        helpText: '',
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030));
    if (picked != null) {
      int pickedUnix = _dateToUnix(picked);
      if (pickedUnix != nowUnixDeadline) {
        return pickedUnix;
      }
    }
    return null;
  }

  void onStartOrEndInput(String? text) {
    if (editingTask.text.isEmpty) {
      if (text != null &&
          (!taskCanBeDeleted && text.isNotEmpty ||
              taskCanBeDeleted && text.isEmpty)) {
        if (_stateIsLoaded) {
          emit(EditingTaskState.loaded(
              editingTask: editingTask,
              switchValue: switchValue,
              taskCanBeDeleted: !taskCanBeDeleted));
        }
      }
    }
  }

  Future<void> onTapeOnDate(BuildContext context) async {
    if (_stateIsLoaded) {
      if (editingTask.deadline != null && switchValue) {
        int? newDeadLine = await _selectDeadLine(context);
        if (newDeadLine != null) {
          emit(EditingTaskState.loaded(
              editingTask: editingTask.copyWith(deadline: newDeadLine),
              switchValue: switchValue,
              taskCanBeDeleted: taskCanBeDeleted));
        }
      }
    }
  }

  Future<void> changeSwitch(BuildContext context) async {
    if (_stateIsLoaded) {
      emit(EditingTaskState.loaded(
          editingTask: editingTask,
          switchValue: !switchValue,
          taskCanBeDeleted: taskCanBeDeleted));
      if (switchValue && editingTask.deadline == null) {
        int? newDeadline = await _selectDeadLine(context);
        if (newDeadline != null) {
          emit(EditingTaskState.loaded(
              editingTask: editingTask.copyWith(deadline: newDeadline),
              switchValue: switchValue,
              taskCanBeDeleted: taskCanBeDeleted));
        } else {
          emit(EditingTaskState.loaded(
              editingTask: editingTask,
              switchValue: !switchValue,
              taskCanBeDeleted: taskCanBeDeleted));
        }
      }
    }
  }

  void changeImportance(Importance? importance) {
    if (importance != null && _stateIsLoaded) {
      emit(EditingTaskState.loaded(
          editingTask: editingTask.copyWith(importance: importance),
          switchValue: switchValue,
          taskCanBeDeleted: taskCanBeDeleted));
    }
  }

  void deleteTask(BuildContext context) {
    if (_stateIsLoaded && taskCanBeDeleted) {
      logger.info('Delete task');
      cubitsConnectorRepo.deleteTask(editingTask);
    }
    (Router.of(context).routerDelegate as BookshelfRouterDelegate)
        .gotoTaskList();
  }

  void saveTask(BuildContext context, String text) {
    if (_stateIsLoaded) {
      Task savedTaskModel = editingTask.copyWith(
        text: text,
        changedAt: _dateToUnix(DateTime.now()),
        lastUpdatedBy: Cont.getIt.get<DeviceIdHolder>().getDeviceId,
      );

      cubitsConnectorRepo.addNewTask(savedTaskModel);
      logger.info('Save task');
    }

    (Router.of(context).routerDelegate as BookshelfRouterDelegate)
        .gotoTaskList();
  }
}
