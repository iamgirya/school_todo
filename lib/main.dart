import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_todo/navigation/root_names_container.dart';
import 'package:school_todo/ui/task_list_page/task_list_page.dart';

import 'navigation/navigation_controller.dart';
import 'ui/editor_page/editor_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationController = NavigationController();
    return Provider<NavigationController>.value(
      value: navigationController,
      child: MaterialApp(
        navigatorKey: navigationController.key,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case RouteNames.editorPage:
              return MaterialPageRoute(
                  builder: (_) =>
                      EditorPage());
            case RouteNames.taskListPage:
              return MaterialPageRoute(
                  builder: (_) =>
                      TaskListPage());
          }
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const EditorPage(),
      ),
    );
  }
}