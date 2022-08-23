import 'dart:async';

import 'package:flutter/material.dart';
import 'package:school_todo/core/logger.dart';
import 'package:school_todo/ui/my_app.dart';

import '../testing_service_locator.dart';



void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    Color importantColor = Colors.red;

    initLogger();
    logger.info('Start main');

    await initTestingServiceLocator();

    runApp(MyApp(importantColor: importantColor));
  }, (_, __) {});
}