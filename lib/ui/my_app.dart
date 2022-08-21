import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:school_todo/ui/task_list_page/task_list_page.dart';

import '../core/logger.dart';
import '../generated/l10n.dart';
import '../models/task_model.dart';
import '../navigation/navigation_controller.dart';
import '../navigation/root_names_container.dart';
import '../styles/app_colors.dart';
import 'editor_page/editor_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.importantColor}) : super(key: key);

  final Color importantColor;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLightTheme = true;
  final navigationController = NavigationController();

  void toggleTheme() {
    setState(() => isLightTheme = !isLightTheme);
  }

  @override
  Widget build(BuildContext context) {
    return Provider<NavigationController>.value(
      value: navigationController,
      child: MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        navigatorKey: navigationController.key,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case RouteNames.editorPage:
              return MaterialPageRoute(builder: (_) {
                Task? initTask = settings.arguments as Task?;
                logger.info(
                    'Open editor with task index: ${initTask == null ? 'new' : initTask.id.toString()}');
                return EditorPage(
                  editingTask: (settings.arguments as Task?),
                );
              });
            case RouteNames.taskListPage:
              return MaterialPageRoute(builder: (_) {
                logger.info('Open task list');
                return TaskListPage(toggleTheme: toggleTheme);
              });
          }
          return null;
        },
        theme: ThemeData.light().copyWith(
          extensions: <ThemeExtension<dynamic>>
          [
            ToDoAppLightColors(
              widget.importantColor,
            ),
          ],
        ),
        darkTheme: ThemeData.dark().copyWith(
          extensions: <ThemeExtension<dynamic>>
          [
            ToDoAppDarkColors(
              widget.importantColor,
            ),
          ],
        ),
        themeMode: isLightTheme ? ThemeMode.light : ThemeMode.dark,
        home: TaskListPage(toggleTheme: toggleTheme),
      ),
    );
  }
}
