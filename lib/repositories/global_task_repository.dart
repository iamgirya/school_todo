import 'dart:convert';

import 'package:dio/dio.dart';
import 'dart:io';

import '../models/task_model.dart';

abstract class IGlobalTaskSavesRepository {
  static const String baseUrl = 'https://beta.mrdekk.ru/todobackend';

  static const String apiToken = "Puding";

  Future<List<Task>> getGlobalTaskList();
  Future<List<Task>> patchGlobalTaskList(List<Task> loadedTasks);

  Future<Task> getGlobalTask(String id);
  Future<Task> postGlobalTask(Task postTask);
  Future<Task> putGlobalTask(String id, Task putTask);
  Future<Task> deleteGlobalTask(String id);
}

class GlobalTaskSavesRepository implements IGlobalTaskSavesRepository {
  String get baseUrl => IGlobalTaskSavesRepository.baseUrl;
  String get apiToken => IGlobalTaskSavesRepository.apiToken;

  int _revision = 0;
  int get revision => _revision;
  set revision(int newRevision) {
    if (newRevision > _revision) {
      _revision = newRevision;
    }
  }

  bool responseIsSuccessful(Response<Map<String, dynamic>> response) {
    return response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300;
  }

  @override
  Future<Task> deleteGlobalTask(String id) async {
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
        return Task.fromJson(response.data!["element"]);
      } else {
        throw Error();
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<Task> getGlobalTask(String id) async {
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
        return Task.fromJson(response.data!["element"]);
      } else {
        throw Error();
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<List<Task>> getGlobalTaskList() async {
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
        return tmpTaskList;
      } else {
        throw Error();
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<List<Task>> patchGlobalTaskList(List<Task> loadedTasks) async {
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
        return tmpTaskList;
      } else {
        throw Error();
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<Task> postGlobalTask(Task postTask) async {
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
        return Task.fromJson(response.data!["element"]);
      } else {
        throw Error();
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<Task> putGlobalTask(String id, Task putTask) async {
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
        return Task.fromJson(response.data!["element"]);
      } else {
        throw Error();
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
