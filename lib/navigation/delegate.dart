import 'package:flutter/material.dart';
import 'package:school_todo/core/container_class.dart';
import 'package:school_todo/navigation/state.dart';
import 'package:school_todo/repositories/local_task_repository.dart';
import 'package:school_todo/ui/task_list_page/task_list_page.dart';

import '../models/task_model.dart';
import '../ui/editor_page/editor_page.dart';

class ToDoRouterDelegate extends RouterDelegate<NavigationStateDTO>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationStateDTO> {
  NavigationState state = NavigationState(true, null);

  bool get isTaskList => state.isOnListPage;

  bool get isEmptyTaskEditor => !state.isOnListPage && state.taskId == null;

  bool get isTaskEditor => !state.isOnListPage && state.taskId != null;

  void gotoTaskList() {
    state
      ..isOnListPage = true
      ..taskId = null;
    notifyListeners();
  }

  void gotoEditor(String? id) {
    state
      ..isOnListPage = false
      ..taskId = id;
    notifyListeners();
  }

  MaterialPage? _taskListPage;

  @override
  Widget build(BuildContext context) {
    _taskListPage ??= const MaterialPage(
      child: TaskListPage(),
    );

    final pages = [
      _taskListPage!,
      if (!state.isOnListPage)
        MaterialPage(
          child: EditorPage(
            editingTask: Cont.getIt
                .get<ILocalTaskSavesRepository>()
                .loadLocalTasks()
                .firstWhere((element) => element.id == state.taskId,
                    orElse: () => Task.empty(null)),
          ),
        ),
    ];
    return Navigator(
      onPopPage: (route, result) => route.didPop(result),
      key: navigatorKey,
      pages: pages,
    );
  }

  @override
  NavigationStateDTO? get currentConfiguration {
    return NavigationStateDTO(state.isOnListPage, state.taskId);
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey();

  @override
  Future<void> setNewRoutePath(NavigationStateDTO configuration) {
    state.taskId = configuration.taskId;
    state.isOnListPage = configuration.isOnListPage;
    return Future.value();
  }
}
