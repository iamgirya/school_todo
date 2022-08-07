import 'dart:convert';

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

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "text": text,
      "importance": importance.name,
      "deadline": deadline,
      "done": done,
      "color": color?.value.toString(),
      "created_at": createdAt,
      "changed_at": changedAt,
      'last_updated_by': lastUpdatedBy
    };
  }

  static Task fromJson(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      text: map['text'] as String,
      importance: (map['importance'] as String).toImportance(),
      deadline: map['deadline'] as int?,
      done: map['done'] as bool,
      color: map['color'] != null ? Color(map['color'] as int) : null,
      createdAt: map['created_at'] as int,
      changedAt: map['changed_at'] as int,
      lastUpdatedBy: map['last_updated_by'] as String,
    );
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;
    return other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
