import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:school_todo/core/firebase.dart';
import 'package:school_todo/navigation/delegate.dart';
import 'package:school_todo/navigation/parser.dart';
import 'package:school_todo/ui/my_app.dart';

import 'core/error_handler.dart';
import 'core/logger.dart';
import 'core/service_locator.dart';

void main() {
  runZonedGuarded(() async {
    debugRepaintRainbowEnabled = false;

    await initFirebase();
    Color importantColor = await getImportantColor();

    initLogger();
    logger.info('Start main');

    ErrorHandler.init();

    await initServiceLocator();

    runApp(MyApp(
      importantColor: importantColor,
      delegate: ToDoRouterDelegate(),
      parser: ToDoRouteInformationParser(),
    ));
  }, ErrorHandler.recordError);
}

// строчка для проверки диплинка в редактор
// adb shell am start -a android.intent.action.VIEW -c android.intent.category.DEFAULT -d school_todo://example/taskList/editor

// код ген
// flutter pub run build_runner build --delete-conflicting-outputs
