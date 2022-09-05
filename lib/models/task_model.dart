import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../core/container_class.dart';
import '../core/device_id_holder.dart';
import 'importance_model.dart';

part 'task_model.g.dart';
part 'task_model.freezed.dart';

@freezed
class Task with _$Task {
  const Task._();

  @HiveType(typeId: 0)
  const factory Task({
    @HiveField(0) required String id,
    @HiveField(1) required String text,
    @HiveField(2) required Importance importance,
    @HiveField(3) int? deadline,
    @HiveField(4) required bool done,
    @HiveField(5) int? color,
    @HiveField(6) @JsonKey(name: 'created_at') required int createdAt,
    @HiveField(7) @JsonKey(name: 'changed_at') required int changedAt,
    @HiveField(8)
    @JsonKey(name: 'last_updated_by')
        required String lastUpdatedBy,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  String? getConvertUnixToStringDate() {
    if (deadline != null) {
      DateFormat dateFormat = DateFormat('d MMM yyyy');
      return dateFormat
          .format(DateTime.fromMillisecondsSinceEpoch(deadline! * 1000));
    } else {
      return null;
    }
  }

  static Task empty(String? text) {
    String deviceId = Cont.getIt.get<DeviceIdHolder>().getDeviceId;

    return Task(
        id: '${DateTime.now().millisecondsSinceEpoch}$deviceId',
        text: text ?? '',
        importance: Importance.basic,
        deadline: null,
        done: false,
        color: null,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        changedAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        lastUpdatedBy: deviceId);
  }
}
