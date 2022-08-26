import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school_todo/core/logger.dart';

import '../models/importance_model.dart';
import '../models/task_model.dart';

abstract class ILocalTaskSavesRepository {
  Future<void> initLocalTaskSavesRepository();

  void saveLocalTasks(List<Task> addedTownList);

  List<Task> loadLocalTasks();

  Task loadLocalTask(String? id);

  int loadLocalRevision();

  void saveLocalRevision(int globalRevision);

  Map<String, bool>? loadConfiguration();

  void saveConfiguration(Map<String, dynamic> configuration);
}

class HiveLocalTaskSavesRepository implements ILocalTaskSavesRepository {
  static const String tasksBoxName = 'tasks';
  static const String tasksBoxListKey = 'tasks';
  static const String tasksBoxRevisionKey = 'revision';
  static const String tasksBoxConfigurationKey = 'isTaskSorted';

  @override
  Future<void> initLocalTaskSavesRepository() async {
    Directory? dir;
    if (Platform.isAndroid) {
      dir = await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      dir = await getApplicationSupportDirectory();
    } else {
      dir = await getTemporaryDirectory();
    }
    Hive.init(dir!.path);

    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(ImportanceAdapter());

    await Hive.openBox(tasksBoxName);
    var tasks = Hive.box(tasksBoxName).get(tasksBoxListKey);
    if (tasks == null) {
      Hive.box(tasksBoxName).put(tasksBoxListKey, []);
    }
    var revision = Hive.box(tasksBoxName).get(tasksBoxRevisionKey);
    if (revision == null) {
      Hive.box(tasksBoxName).put(tasksBoxRevisionKey, 0);
    }
    var isSorted = Hive.box(tasksBoxName).get(tasksBoxConfigurationKey);
    if (isSorted == null) {
      Hive.box(tasksBoxName)
          .put(tasksBoxConfigurationKey, {'isTaskSorting': false});
    }
  }

  @override
  List<Task> loadLocalTasks() {
    logger.info('Local load task');
    return (Hive.box(tasksBoxName).get(tasksBoxListKey) as Iterable)
        .map((e) => e as Task)
        .toList();
  }

  @override
  Task loadLocalTask(String? id) {
    if (id == null) {
      return Task.empty(null);
    }
    try {
      return (Hive.box(tasksBoxName).get(tasksBoxListKey) as Iterable)
          .map((e) => e as Task)
          .firstWhere((element) => element.id == id);
    } catch (e) {
      return Task.empty(null);
    }
  }

  @override
  void saveLocalTasks(List<Task> taskList) {
    logger.info('Local save task');
    Hive.box(tasksBoxName).put(tasksBoxListKey, taskList);
  }

  @override
  int loadLocalRevision() {
    return (Hive.box(tasksBoxName).get(tasksBoxRevisionKey) as int);
  }

  @override
  void saveLocalRevision(int globalRevision) {
    Hive.box(tasksBoxName).put(tasksBoxRevisionKey, globalRevision);
  }

  @override
  Map<String, bool>? loadConfiguration() {
    Map<String, bool> map = Map<String, bool>.from(
        Hive.box(tasksBoxName).get(tasksBoxConfigurationKey));
    return map;
  }

  @override
  void saveConfiguration(Map<String, dynamic> configuration) {
    Hive.box(tasksBoxName).put(tasksBoxConfigurationKey, configuration);
  }
}
