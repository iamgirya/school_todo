// Mocks generated by Mockito 5.3.0 from annotations
// in school_todo/test/cubits_test/task_list_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:school_todo/models/task_model.dart' as _i4;
import 'package:school_todo/repositories/cubits_connector_repository.dart'
    as _i6;
import 'package:school_todo/repositories/global_task_repository.dart' as _i5;
import 'package:school_todo/repositories/local_task_repository.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [ILocalTaskSavesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockILocalTaskSavesRepository extends _i1.Mock
    implements _i2.ILocalTaskSavesRepository {
  MockILocalTaskSavesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<void> initLocalTaskSavesRepository() => (super.noSuchMethod(
      Invocation.method(#initLocalTaskSavesRepository, []),
      returnValue: _i3.Future<void>.value(),
      returnValueForMissingStub: _i3.Future<void>.value()) as _i3.Future<void>);
  @override
  void saveLocalTasks(List<_i4.Task>? addedTownList) =>
      super.noSuchMethod(Invocation.method(#saveLocalTasks, [addedTownList]),
          returnValueForMissingStub: null);
  @override
  List<_i4.Task> loadLocalTasks() =>
      (super.noSuchMethod(Invocation.method(#loadLocalTasks, []),
          returnValue: <_i4.Task>[]) as List<_i4.Task>);
  @override
  int loadLocalRevision() =>
      (super.noSuchMethod(Invocation.method(#loadLocalRevision, []),
          returnValue: 0) as int);
  @override
  void saveLocalRevision(int? globalRevision) => super.noSuchMethod(
      Invocation.method(#saveLocalRevision, [globalRevision]),
      returnValueForMissingStub: null);
}

/// A class which mocks [IGlobalTaskSavesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockIGlobalTaskSavesRepository extends _i1.Mock
    implements _i5.IGlobalTaskSavesRepository {
  MockIGlobalTaskSavesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get isOffline =>
      (super.noSuchMethod(Invocation.getter(#isOffline), returnValue: false)
          as bool);
  @override
  _i3.Future<List<_i4.Task>?> getGlobalTaskList() =>
      (super.noSuchMethod(Invocation.method(#getGlobalTaskList, []),
              returnValue: _i3.Future<List<_i4.Task>?>.value())
          as _i3.Future<List<_i4.Task>?>);
  @override
  _i3.Future<List<_i4.Task>?> patchGlobalTaskList(
          List<_i4.Task>? loadedTasks) =>
      (super.noSuchMethod(
              Invocation.method(#patchGlobalTaskList, [loadedTasks]),
              returnValue: _i3.Future<List<_i4.Task>?>.value())
          as _i3.Future<List<_i4.Task>?>);
  @override
  _i3.Future<_i4.Task?> getGlobalTask(String? id) =>
      (super.noSuchMethod(Invocation.method(#getGlobalTask, [id]),
          returnValue: _i3.Future<_i4.Task?>.value()) as _i3.Future<_i4.Task?>);
  @override
  _i3.Future<_i4.Task?> postGlobalTask(_i4.Task? postTask) =>
      (super.noSuchMethod(Invocation.method(#postGlobalTask, [postTask]),
          returnValue: _i3.Future<_i4.Task?>.value()) as _i3.Future<_i4.Task?>);
  @override
  _i3.Future<_i4.Task?> putGlobalTask(String? id, _i4.Task? putTask) =>
      (super.noSuchMethod(Invocation.method(#putGlobalTask, [id, putTask]),
          returnValue: _i3.Future<_i4.Task?>.value()) as _i3.Future<_i4.Task?>);
  @override
  _i3.Future<_i4.Task?> deleteGlobalTask(String? id) =>
      (super.noSuchMethod(Invocation.method(#deleteGlobalTask, [id]),
          returnValue: _i3.Future<_i4.Task?>.value()) as _i3.Future<_i4.Task?>);
  @override
  int getRevision() =>
      (super.noSuchMethod(Invocation.method(#getRevision, []), returnValue: 0)
          as int);
}

/// A class which mocks [ICubitsConnectorRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockICubitsConnectorRepository extends _i1.Mock
    implements _i6.ICubitsConnectorRepository {
  MockICubitsConnectorRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void addNewTask(_i4.Task? newTask) =>
      super.noSuchMethod(Invocation.method(#addNewTask, [newTask]),
          returnValueForMissingStub: null);
  @override
  void setCallBackOnNewTask(void Function(_i4.Task)? callBack) =>
      super.noSuchMethod(Invocation.method(#setCallBackOnNewTask, [callBack]),
          returnValueForMissingStub: null);
  @override
  void deleteTask(_i4.Task? toDeleteTask) =>
      super.noSuchMethod(Invocation.method(#deleteTask, [toDeleteTask]),
          returnValueForMissingStub: null);
  @override
  void setCallBackOnDeleteTask(void Function(_i4.Task)? callBack) => super
      .noSuchMethod(Invocation.method(#setCallBackOnDeleteTask, [callBack]),
          returnValueForMissingStub: null);
}