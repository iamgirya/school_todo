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

  late int? id;
  late String text;
  late Importance importance;
  late int? deadline;
  late bool done;
  late Color? color;
  late int createdAt;
  late int changedAt;
  late int lastUpdatedBy;
}

enum Importance {
  basic ,
  low ,
  important,
}