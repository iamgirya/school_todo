import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:school_todo/core/logger.dart';

import '../firebase_options.dart';

final remoteConfig = FirebaseRemoteConfig.instance;

Future<void> initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (error) {
    logger.severe('Ошибка подключения Firebase', [error]);
  }
}

Future<Color> getImportantColor() async {
  try {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(seconds: 5),
    ));
    await remoteConfig.fetchAndActivate();
    return Color(remoteConfig.getInt('importantColor'));
  } catch (error) {
    logger.severe('Ошибка подключения Remote Config', [error]);
    return Colors.red;
  }

}
