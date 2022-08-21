import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'logger.dart';

class ErrorHandler {
  static void init() {
    FlutterError.onError = _recordFlutterError;
    logger.info('ErrorHandler initialized');
  }

  static void recordError(Object error, StackTrace stackTrace) {
    if (Firebase.apps != []) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
    }
    logger.severe(
      error.toString(),
      error,
      stackTrace,
    );
  }

  static void _recordFlutterError(FlutterErrorDetails error) {
    if (Firebase.apps != []) {
      FirebaseCrashlytics.instance.recordFlutterError(error);
    }
    logger.severe(error.toStringShort(), error.exception, error.stack);
  }

  const ErrorHandler._();
}
