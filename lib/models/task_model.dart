import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:school_todo/core/container_class.dart';

import 'importance_model.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task {
  Task({
    required this.id,
    required this.text,
    required this.importance,
    required this.deadline,
    required this.done,
    required this.color,
    required this.createdAt,
    required this.changedAt,
    required this.lastUpdatedBy,
  });

  Task.empty() {
    id = '${DateTime.now().millisecondsSinceEpoch}${Cont.getDeviceId}';
    text = "";
    importance = Importance.basic;
    done = false;
    createdAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    changedAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    // айди устройства
    lastUpdatedBy = Cont.getDeviceId;
  }

  @HiveField(0)
  late String id;
  @HiveField(1)
  late String text;
  @HiveField(2)
  late Importance importance;
  @HiveField(3)
  int? deadline;
  @HiveField(4)
  late bool done;
  @HiveField(5)
  Color? color;
  @HiveField(6)
  late int createdAt;
  @HiveField(7)
  late int changedAt;
  @HiveField(8)
  late String lastUpdatedBy;

  String toJson() {
    return '{"importance":$importance,"deadline":$deadline,"text":$text}';
  }
}
