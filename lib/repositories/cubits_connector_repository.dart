import 'dart:async';

import '../models/task_model.dart';

abstract class ICubitsConnectorRepository {
  late void Function(Task) _onNewTask;

  void addNewTask(Task newTask);

  void setCallBackOnNewTask(void Function(Task) callBack);

  late void Function(Task) _onDeleteTask;

  void deleteTask(Task toDeleteTask);

  void setCallBackOnDeleteTask(void Function(Task) callBack);
}

class SimpleCubitsConnectorRepository implements ICubitsConnectorRepository {
  @override
  late void Function(Task newTask) _onNewTask;

  @override
  void addNewTask(Task newTask) {
    _onNewTask(newTask);
  }

  @override
  void setCallBackOnNewTask(void Function(Task) callBack) {
    _onNewTask = callBack;
  }

  @override
  late void Function(Task toDeleteTask) _onDeleteTask;

  @override
  void deleteTask(Task toDeleteTask) {
    _onDeleteTask(toDeleteTask);
  }

  @override
  void setCallBackOnDeleteTask(void Function(Task) callBack) {
    _onDeleteTask = callBack;
  }
}
