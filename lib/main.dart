import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:school_todo/core/firebase.dart';
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

    runApp(MyApp(importantColor: importantColor));
  }, ErrorHandler.recordError);
}