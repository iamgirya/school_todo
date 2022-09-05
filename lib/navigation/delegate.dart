import 'package:flutter/material.dart';
import 'package:school_todo/core/container_class.dart';
import 'package:school_todo/navigation/root_names_container.dart';
import 'package:school_todo/navigation/state.dart';
import 'package:school_todo/repositories/local_task_repository.dart';
import 'package:school_todo/ui/task_list_page/task_list_page.dart';

import '../core/app_metrica_controller.dart';
import '../ui/editor_page/editor_page.dart';

class ToDoRouterDelegate extends RouterDelegate<NavigationStateDTO>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationStateDTO> {
  NavigationState state = NavigationState(true, null);
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  bool get isTaskList => state.isOnListPage;

  bool get isEmptyTaskEditor => !state.isOnListPage && state.taskId == null;

  bool get isTaskEditor => !state.isOnListPage && state.taskId != null;

  void gotoTaskList() {
    state
      ..isOnListPage = true
      ..taskId = null;
    notifyListeners();

    Cont.getIt.get<AppMetricaController>().reportEventWithMap(
        'Open Screen', {'screenName': RouteNames.taskListPage});
  }

  void gotoEditor(String? id) {
    state
      ..isOnListPage = false
      ..taskId = id;
    notifyListeners();

    Cont.getIt.get<AppMetricaController>().reportEventWithMap(
        'Open Screen', {'screenName': RouteNames.editorPage});
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        if (!isTaskList) {
          gotoTaskList();
        }
        popRoute();
        return true;
      },
      key: navigatorKey,
      pages: [
        const MaterialPage(
          child: TaskListPage(
              // key: GlobalKey(),
              ),
        ),
        if (!state.isOnListPage)
          MaterialPage(
            child: EditorPage(
              editingTask: Cont.getIt
                  .get<LocalTaskSavesRepository>()
                  .loadLocalTask(state.taskId),
            ),
          ),
      ],
    );
  }

  @override
  NavigationStateDTO? get currentConfiguration {
    return NavigationStateDTO(state.isOnListPage, state.taskId);
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigationKey;

  @override
  Future<void> setNewRoutePath(NavigationStateDTO configuration) {
    state.taskId = configuration.taskId;
    state.isOnListPage = configuration.isOnListPage;
    return Future.value();
  }
}
