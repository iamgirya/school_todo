import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_todo/navigation/root_names_container.dart';

class NavigationController {
  final GlobalKey<NavigatorState> _key1 = GlobalKey();

  GlobalKey<NavigatorState> get key => _key1;


  void navigateTo(String page, {Object? arguments}) async {
    AppMetrica.reportEventWithMap('Open Screen', {'screenName' : RouteNames.editorPage});
    _key1.currentState?.pushNamed(page, arguments: arguments);
  }

  void pop([Object? result]) {
    AppMetrica.reportEventWithMap('Open Screen', {'screenName' : RouteNames.taskListPage});
    _key1.currentState?.pop(result);
  }

  Future<T> pushDialog<T>(RawDialogRoute<T> route) async {
    return _key1.currentState?.push<T>(route) as Future<T>;
  }
}
