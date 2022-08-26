import 'dart:async';

import 'package:school_todo/navigation/delegate.dart';
import 'package:school_todo/navigation/parser.dart';

import 'core/error_handler.dart';
import 'core/firebase.dart';
import 'main_common.dart' as main_common;
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter/material.dart';

import 'ui/my_app.dart';

void main() {
  FlavorConfig(
    name: 'DEV',
    color: Colors.blue,
    location: BannerLocation.topEnd,
    variables: {
      "isTestFlavor": true,
    },
  );

  runZonedGuarded(() async {
    await main_common.main();
    Color importantColor = await getImportantColor();

    runApp(MyApp(
      importantColor: importantColor,
      delegate: ToDoRouterDelegate(),
      parser: ToDoRouteInformationParser(),
    ));
  }, ErrorHandler.recordError);
}
