import 'package:flutter/material.dart';

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
    text = "";
    importance = Importance.basic;
    done = false;
    createdAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    changedAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    // айди устройства
    lastUpdatedBy = 0;
  }

  int? id;
  late String text;
  late Importance importance;
  int? deadline;
  late bool done;
  Color? color;
  late int createdAt;
  late int changedAt;
  late int lastUpdatedBy;

  String toJson() {
    return '{"importance":$importance,"deadline":$deadline,"text":$text}';
  }
}

enum Importance {
  basic,
  low,
  important,
}
