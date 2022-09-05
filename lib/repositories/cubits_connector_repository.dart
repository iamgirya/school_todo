import '../models/task_model.dart';

abstract class CubitsConnectorRepository {
  void addNewTask(Task newTask);

  void setCallBackOnNewTask(void Function(Task) callBack);

  void deleteTask(Task toDeleteTask);

  void setCallBackOnDeleteTask(void Function(Task) callBack);
}

class CubitsConnectorRepositoryImpl implements CubitsConnectorRepository {
  late void Function(Task newTask) _onNewTask;

  @override
  void addNewTask(Task newTask) {
    _onNewTask(newTask);
  }

  @override
  void setCallBackOnNewTask(void Function(Task) callBack) {
    _onNewTask = callBack;
  }

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
