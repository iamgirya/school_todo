import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:school_todo/repositories/cubits_connectror_repository.dart';
import 'package:school_todo/repositories/local_task_repository.dart';

import '../models/task_model.dart';
import '../repositories/global_task_repository.dart';

abstract class Cont {
  static ILocalTaskSavesRepository localTaskSavesRepository =
      LocalTaskSavesRepository();
  static ICubitsConnectorRepository cubitsConnectorRepository =
      SimpleCubitsConnectorRepository();
  static IGlobalTaskSavesRepository globalTaskSavesRepository =
      GlobalTaskSavesRepository();

  static String? convertUnixToStringDate(int? unix) {
    if (unix != null) {
      DateFormat dateFormat = DateFormat("d MMM yyyy");

      return dateFormat
          .format(DateTime.fromMillisecondsSinceEpoch(unix * 1000));
    } else {
      return null;
    }
  }

  // временный список для тестирования
  static List<Task> localTaskList = [
    Task(
        id: 0,
        text: "text",
        importance: Importance.basic,
        deadline: 1000000,
        done: false,
        color: null,
        createdAt: 12,
        changedAt: 13,
        lastUpdatedBy: 14),
    Task(
        id: 1,
        text: "texter",
        importance: Importance.important,
        deadline: 12,
        done: true,
        color: Colors.red,
        createdAt: 14,
        changedAt: 17,
        lastUpdatedBy: 20),
    Task(
        id: 2,
        text: "text",
        importance: Importance.basic,
        deadline: 10,
        done: false,
        color: null,
        createdAt: 12,
        changedAt: 13,
        lastUpdatedBy: 14),
    Task(
        id: 3,
        text: "texter",
        importance: Importance.important,
        deadline: 12,
        done: true,
        color: Colors.red,
        createdAt: 14,
        changedAt: 17,
        lastUpdatedBy: 20),
    Task(
        id: 4,
        text: "text",
        importance: Importance.basic,
        deadline: 10,
        done: false,
        color: null,
        createdAt: 12,
        changedAt: 13,
        lastUpdatedBy: 14),
    Task(
        id: 5,
        text: "texter",
        importance: Importance.important,
        deadline: 12,
        done: true,
        color: Colors.red,
        createdAt: 14,
        changedAt: 17,
        lastUpdatedBy: 20),
    Task(
        id: 6,
        text: "text",
        importance: Importance.basic,
        deadline: 10,
        done: false,
        color: null,
        createdAt: 12,
        changedAt: 13,
        lastUpdatedBy: 14),
    Task(
        id: 7,
        text: "texter",
        importance: Importance.important,
        deadline: null,
        done: true,
        color: Colors.red,
        createdAt: 14,
        changedAt: 17,
        lastUpdatedBy: 20),
    Task(
        id: 8,
        text: "text",
        importance: Importance.basic,
        deadline: 10,
        done: false,
        color: null,
        createdAt: 12,
        changedAt: 13,
        lastUpdatedBy: 14),
    Task(
        id: 9,
        text: "tester",
        importance: Importance.important,
        deadline: null,
        done: true,
        color: Colors.red,
        createdAt: 14,
        changedAt: 17,
        lastUpdatedBy: 20),
  ];
}
