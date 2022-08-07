import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school_todo/core/logger.dart';

import '../models/importance_model.dart';
import '../models/task_model.dart';

abstract class ILocalTaskSavesRepository {
  Future<void> initLocalTaskSavesRepository();

  Future<void> saveLocalTasks(List<Task> addedTownList);

  List<Task> loadLocalTasks();
}

class HiveLocalTaskSavesRepository implements ILocalTaskSavesRepository {
  static const String tasksBoxName = "tasks";
  static const String tasksBoxKey = "tasks";

  @override
  Future<void> initLocalTaskSavesRepository() async {
    Directory? dir;
    if (Platform.isAndroid) {
      dir = await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      dir = await getApplicationSupportDirectory();
    }
    Hive.init(dir!.path);

    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(ImportanceAdapter());

    await Hive.openBox(tasksBoxName);
    var tasks = Hive.box(tasksBoxName).get(tasksBoxName);
    if (tasks == null) {
      Hive.box(tasksBoxName).put(tasksBoxKey, []);
    }
  }

  @override
  List<Task> loadLocalTasks() {
    logger.info("Local load task");
    return (Hive.box(tasksBoxName).get(tasksBoxKey) as Iterable)
        .map((e) => e as Task)
        .toList();
  }

  @override
  Future<void> saveLocalTasks(List<Task> taskList) async {
    logger.info("Local save task");
    await Hive.box(tasksBoxName).put(tasksBoxKey, taskList);
  }
}
