import 'package:flutter/material.dart';

import '../models/task_model.dart';

abstract class Cont {
  static List<Task> localTaskList = [
    Task(id: 0, text: "text", importance: Importance.basic, deadline: 10, done: false, color: null, createdAt: 12, changedAt: 13, lastUpdatedBy: 14),
    Task(id: 1, text: "texter", importance: Importance.important, deadline: 12, done: true, color: Colors.red, createdAt: 14, changedAt: 17, lastUpdatedBy: 20),
  ];
}