import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:school_todo/navigation/delegate.dart';
import 'package:school_todo/navigation/parser.dart';
import 'package:school_todo/ui/task_list_page/task_list_page.dart';

import '../core/logger.dart';
import '../generated/l10n.dart';
import '../models/task_model.dart';
import '../navigation/navigation_controller.dart';
import '../navigation/root_names_container.dart';
import '../styles/app_colors.dart';
import 'editor_page/editor_page.dart';

class MyApp extends StatelessWidget {
  const MyApp(
      {Key? key,
      required this.importantColor,
      required this.delegate,
      required this.parser})
      : super(key: key);

  final Color importantColor;
  final bool isLightTheme = true;
  final BookshelfRouterDelegate delegate;
  final BooksShelfRouteInformationParser parser;

  // void toggleTheme() {
  //   setState(() => isLightTheme = !isLightTheme);
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: delegate,
      routeInformationParser: parser,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData.light().copyWith(
        extensions: <ThemeExtension<dynamic>>[
          ToDoAppLightColors(
            importantColor,
          ),
        ],
      ),
      darkTheme: ThemeData.dark().copyWith(
        extensions: <ThemeExtension<dynamic>>[
          ToDoAppDarkColors(
            importantColor,
          ),
        ],
      ),
      themeMode: isLightTheme ? ThemeMode.light : ThemeMode.dark,
    );
  }
}
