import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:school_todo/navigation/navigation_controller.dart';
import 'package:school_todo/repositories/cubits_connector_repository.dart';
import '../../core/device_id_holder.dart';
import '../../models/importance_model.dart';
import '../../models/task_model.dart';
import 'editing_task_state.dart';

class EditingTaskCubit extends Cubit<EditingTaskState> {
  EditingTaskCubit({Task? initTask, required this.cubitsConnectorRepo})
      : super(EditingTaskReady(editingTask: initTask ?? Task.empty(""))) {
    textController = TextEditingController();
    textController.addListener(_onStartOrEndInput);
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
  bool _taskCanBeDeleted = false;

  bool get _stateIsHasData => state is EditingTaskHasData;

  int dateToUnix(DateTime date) => date.millisecondsSinceEpoch ~/ 1000;

  Task get taskModel => (state as EditingTaskHasData).editingTask;
  set taskModel (Task value) {
    emit(EditingTaskReady(editingTask: value));
  }

  void _onStartOrEndInput() {
    if (!_taskCanBeDeleted && textController.text != "" || _taskCanBeDeleted && textController.text == "") {
      _taskCanBeDeleted = !_taskCanBeDeleted;
      if (_stateIsHasData) {
        emit(EditingTaskWaitingChanges(editingTask: taskModel));
        emit(EditingTaskReady(editingTask: taskModel));
      }
    }
  }

  Future<void> _selectDeadLine(BuildContext context) async {
    int? nowUnixDeadline = taskModel.deadline;
    final DateTime? picked = await showDatePicker(
        helpText: "",
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
      cubitsConnectorRepo.deleteTask(taskModel);
    }
    context.read<NavigationController>().pop();
  }

  void saveTask(BuildContext context) {
    GetIt getIt = GetIt.instance;
    if (_stateIsHasData) {
      Task savedTaskModel = taskModel.copyWith(
          text: textController.text,
          changedAt: dateToUnix(DateTime.now()),
          lastUpdatedBy: getIt.get<DeviceIdHolder>().getDeviceId,
      );

      cubitsConnectorRepo.addNewTask(savedTaskModel);
    }

    context.read<NavigationController>().pop();
  }
}
