import 'package:flutter/foundation.dart';

class NavigationState with ChangeNotifier {
  bool _isOnListPage;
  String? _taskId;
  NavigationState(this._isOnListPage, this._taskId);

  bool get isOnListPage => _isOnListPage;
  set isOnListPage(bool val) {
    _isOnListPage = val;
    notifyListeners();
  }

  String? get taskId => _taskId;
  set taskId(String? val) {
    _taskId = val;
    notifyListeners();
  }

  @override
  String toString() => "Welcome: $_isOnListPage, book: $_taskId";
}

class NavigationStateDTO {
  bool isOnListPage;
  String? taskId;
  NavigationStateDTO(this.isOnListPage, this.taskId);
  NavigationStateDTO.taskList()
      : isOnListPage = true,
        taskId = null;
  NavigationStateDTO.taskEditor(this.taskId) : isOnListPage = false;
}
