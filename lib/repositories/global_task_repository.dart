import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../core/logger.dart';
import '../models/task_model.dart';

abstract class IGlobalTaskSavesRepository {
  static const String baseUrl = 'https://beta.mrdekk.ru/todobackend';

  static const String apiToken = "Puding";

  get isOffline => true;

  Future<List<Task>?> getGlobalTaskList();
  Future<List<Task>?> patchGlobalTaskList(List<Task> loadedTasks);

  Future<Task?> getGlobalTask(String id);
  Future<Task?> postGlobalTask(Task postTask);
  Future<Task?> putGlobalTask(String id, Task putTask);
  Future<Task?> deleteGlobalTask(String id);
}

class GlobalTaskSavesRepository implements IGlobalTaskSavesRepository {
  String get baseUrl => IGlobalTaskSavesRepository.baseUrl;
  String get apiToken => IGlobalTaskSavesRepository.apiToken;

  bool _isOffline = false;
  @override
  bool get isOffline => _isOffline;
  set isOffline(bool value) {
    _isOffline = value;
  }

  int _revision = 0;
  int get revision => _revision;
  set revision(int newRevision) {
    if (newRevision > _revision) {
      _revision = newRevision;
    }
  }

  bool _isOfflineCheck() {
    if (isOffline) {
      logger.info("App is offline, request denied");
    }
    return isOffline;
  }

  void _onError(error) {
    if (error is DioError) {
      if (error.response?.statusCode == 400) {
        logger.severe("Error: wrong request", [error]);
      } else if (error.response?.statusCode == 401) {
        logger.severe("Error: wrong authorization", [error]);
        isOffline = true;
      } else if (error.response?.statusCode == 404) {
        logger.severe("Error: element not found", [error]);
      } else if ((error.response?.statusCode) != null && (error.response?.statusCode)! >= 500) {
        logger.severe("Error: server error", [error]);
        isOffline = true;
      } if (error.error is SocketException) {
        logger.severe("Error: lost Internet connection", [error]);
        isOffline = true;
      } else {
        logger.severe("Error: unknown request error", [error]);
        isOffline = true;
      }
    } else {
      logger.severe("Error: unknown error", [error]);
      isOffline = true;
    }
  }

  bool responseIsSuccessful(Response<Map<String, dynamic>> response) {
    return response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300;
  }

  @override
  Future<Task?> deleteGlobalTask(String id) async {
    if (_isOfflineCheck()) {
      return null;
    }
    logger.info("Delete global task");
    try {
      Response<Map<String, dynamic>> response = await Dio().delete(
        "$baseUrl/list/$id",
        options: Options(
          headers: {
            "X-Last-Known-Revision": revision,
            "Authorization": "Bearer $apiToken",
          },
        ),
      );
      if (responseIsSuccessful(response)) {
        revision = response.data!["revision"];
        logger.info("Success delete global task");
        return Task.fromJson(response.data!["element"]);
      } else {
        throw Error();
      }
    } catch (error) {
      _onError(error);
      return null;
    }

  }

  @override
  Future<Task?> getGlobalTask(String id) async {
    if (_isOfflineCheck()) {
      return null;
    }
    logger.info("Get global task");
    try {
      Response<Map<String, dynamic>> response = await Dio().get(
        "$baseUrl/list/$id",
        options: Options(
          headers: {
            "Authorization": "Bearer $apiToken",
          },
        ),
      );
      if (responseIsSuccessful(response)) {
        revision = response.data!["revision"];
        logger.info("Success get global task");
        return Task.fromJson(response.data!["element"]);
      } else {
        throw Error();
      }
    } catch (error) {
      _onError(error);
      return null;
    }
  }

  @override
  Future<List<Task>?> getGlobalTaskList() async {
    if (_isOfflineCheck()) {
      return null;
    }
    logger.info("Get global task list");
    try {
      Response<Map<String, dynamic>> response = await Dio().get(
        "$baseUrl/list",
        options: Options(
          headers: {
            "Authorization": "Bearer $apiToken",
          },
        ),
      );
      List<Task> tmpTaskList = [];

      if (responseIsSuccessful(response)) {
        revision = response.data!["revision"];
        for (Map<String, dynamic> task in response.data!["list"]) {
          tmpTaskList.add(Task.fromJson(task));
        }
        logger.info("Success get global task list");
        return tmpTaskList;
      } else {
        throw Error();
      }
    } catch (error) {
      _onError(error);
      return null;
    }
  }

  @override
  Future<List<Task>?> patchGlobalTaskList(List<Task> loadedTasks) async {
    if (_isOfflineCheck()) {
      return null;
    }
    logger.info("Patch global task list");
    try {
      Response<Map<String, dynamic>> response = await Dio().patch(
        "$baseUrl/list",
        options: Options(
          headers: {
            "Authorization": "Bearer $apiToken",
            "X-Last-Known-Revision": revision,
            "Content-Type": "application/json",
          },
        ),
        data: jsonEncode({
          "status": "ok",
          "list": loadedTasks.map((e) => e.toJson()).toList(),
        }),
      );
      List<Task> tmpTaskList = [];

      if (responseIsSuccessful(response)) {
        revision = response.data!["revision"];
        for (Map<String, dynamic> task in response.data!["list"]) {
          tmpTaskList.add(Task.fromJson(task));
        }
        logger.info("Success patch global task list");
        return tmpTaskList;
      } else {
        throw Error();
      }
    } catch (error) {
      _onError(error);
      return null;
    }
  }

  @override
  Future<Task?> postGlobalTask(Task postTask) async {
    if (_isOfflineCheck()) {
      return null;
    }
    logger.info("Post global task");
    try {
      Response<Map<String, dynamic>> response = await Dio().post(
        "$baseUrl/list",
        options: Options(
          headers: {
            "X-Last-Known-Revision": revision,
            "Authorization": "Bearer $apiToken",
            "Content-Type": "application/json",
          },
        ),
        data: jsonEncode({
          "status": "ok",
          "element": postTask.toJson(),
        }),
      );
      if (responseIsSuccessful(response)) {
        revision = response.data!["revision"];
        logger.info("Success post global task list");
        return Task.fromJson(response.data!["element"]);
      } else {
        throw Error();
      }
    } catch (error) {
      _onError(error);
      return null;
    }
  }

  @override
  Future<Task?> putGlobalTask(String id, Task putTask) async {
    if (_isOfflineCheck()) {
      return null;
    }
    logger.info("Put global task");
    try {
      Response<Map<String, dynamic>> response = await Dio().put(
        "$baseUrl/list/$id",
        options: Options(
          headers: {
            "X-Last-Known-Revision": revision,
            "Authorization": "Bearer $apiToken",
            "Content-Type": "application/json",
          },
        ),
        data: jsonEncode({
          "status": "ok",
          "element": putTask.toJson(),
        }),
      );
      if (responseIsSuccessful(response)) {
        revision = response.data!["revision"];
        logger.info("Success put global task list");
        return Task.fromJson(response.data!["element"]);
      } else {
        throw Error();
      }
    } catch (error) {
      _onError(error);
      return null;
    }
  }
}
