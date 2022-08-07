import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:school_todo/core/logger.dart';

import '../firebase_options.dart';
import '../styles/app_colors.dart';

final remoteConfig = FirebaseRemoteConfig.instance;

void iniFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 1),
      minimumFetchInterval: const Duration(seconds: 10),
    ));
    await remoteConfig.fetchAndActivate();
    AppLightColors.importTaskColor =
        Color(remoteConfig.getInt("importantColor"));
  } catch (error) {
    logger.severe("Ошибка подключения Firebase", [error]);
    AppLightColors.importTaskColor = AppLightColors.red;
  }
}
