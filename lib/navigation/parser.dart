import 'package:flutter/widgets.dart';
import 'package:school_todo/navigation/root_names_container.dart';
import 'package:school_todo/navigation/state.dart';

//Transform state <-> URL
class BooksShelfRouteInformationParser
    extends RouteInformationParser<NavigationStateDTO> {
  @override
  Future<NavigationStateDTO> parseRouteInformation(
      RouteInformation routeInformation) {
    final uri = Uri.parse(routeInformation.location ?? '');

    if (uri.pathSegments.length == 1 &&
        uri.pathSegments[0] == RouteNames.taskListPage) {
      return Future.value(NavigationStateDTO.taskList());
    } else if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[1] == RouteNames.editorPage) {
        return Future.value(NavigationStateDTO.taskEditor(null));
      } else {
        return Future.value(NavigationStateDTO.taskEditor(uri.pathSegments[1]));
      }
    }

    return Future.value(NavigationStateDTO.taskList());
  }

  @override
  RouteInformation? restoreRouteInformation(NavigationStateDTO configuration) {
    if (configuration.isOnListPage) {
      return const RouteInformation(location: '/${RouteNames.taskListPage}');
    } else if (configuration.taskId == null) {
      return const RouteInformation(
          location: '/${RouteNames.taskListPage}/${RouteNames.editorPage}');
    } else {
      return RouteInformation(
          location: '/${RouteNames.taskListPage}/${configuration.taskId}');
    }
  }
}
