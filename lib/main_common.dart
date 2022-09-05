import 'dart:async';

import 'package:school_todo/core/firebase.dart';

import 'core/error_handler.dart';
import 'core/logger.dart';
import 'core/service_locator.dart';

Future<void> main() async {
  await initFirebase();

  initLogger();
  logger.info('Start main');

  ErrorHandler.init();

  await initServiceLocator();
}

// строчка для проверки диплинка в редактор
// adb shell am start -a android.intent.action.VIEW -c android.intent.category.DEFAULT -d school_todo://example/taskList/editor

// код ген
// flutter pub run build_runner build --delete-conflicting-outputs
