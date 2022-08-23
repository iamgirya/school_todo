import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/core/app_metrica_controller.dart';
import 'package:school_todo/core/logger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/container_class.dart';
import '../../models/animated_task_model.dart';
import '../../models/task_model.dart';
import '../../repositories/local_task_repository.dart';

import '../../repositories/cubits_connector_repository.dart';
import '../../repositories/global_task_repository.dart';

part 'task_list_state.dart';
part 'task_list_cubit.freezed.dart';

class TaskListCubit extends Cubit<TaskListState> {
  TaskListCubit(
      {required this.localRepo,
        required this.globalRepo,
        required this.cubitsConnectorRepo})
      : super(const TaskListState.initial()) {
    cubitsConnectorRepo.setCallBackOnNewTask(onGetTaskFromEditor);
    cubitsConnectorRepo.setCallBackOnDeleteTask(deleteTask);
  }

  final ILocalTaskSavesRepository localRepo;
  final IGlobalTaskSavesRepository globalRepo;
  final ICubitsConnectorRepository cubitsConnectorRepo;

  List<AnimatedTask> get loadedTasks => (state as TaskListLoadedState).loadedTasks;
  bool get isCompletedVisible => (state as TaskListLoadedState).isCompletedVisible;

  Future<void> _doServerRequest(Future<void> Function() serverRequest) async {
    bool isConnected = globalRepo.isOffline;
    await serverRequest();
    localRepo.saveLocalRevision(globalRepo.getRevision());
    if (isConnected && !globalRepo.isOffline) {
      globalRepo.patchGlobalTaskList(localRepo.loadLocalTasks());
    }
  }

  List<Task> _checkLocalChanges(List<Task> localTasks, List<Task> globalTasks)  {
    int localRevision = localRepo.loadLocalRevision();
    int globalRevision = globalRepo.getRevision();

    if (localRevision < globalRevision) {
      logger.info('Global data is main');
      localRepo.saveLocalRevision(globalRevision);
      localRepo.saveLocalTasks(globalTasks);
      return globalTasks;
    } else {
      logger.info('Local data is main');
      globalRepo.patchGlobalTaskList(localTasks);
      return localTasks;
    }
  }

  int getLengthOfTaskList() {
    if (state is TaskListLoadedState) {
      return loadedTasks.length;
    }
    return 0;
  }

  int getUnLengthOfCompletedTaskList() {
    if (state is TaskListLoadedState) {
      return loadedTasks.where((element) => !element.task.done || (element.task.done && element.isAnimated)).length;
    }
    return 0;
  }

  Task getTask(int index) {
    if (state is TaskListLoadedState) {
      return loadedTasks[index].task;
    } else {
      throw Error();
    }
  }

  Task getUnCompletedTask(int index) {
    if (state is TaskListLoadedState) {
      int unCompletedIndex = -1;
      for (int i = 0; i < loadedTasks.length; i++) {
        if (!loadedTasks[i].task.done || (loadedTasks[i].task.done && loadedTasks[i].isAnimated)) {
          unCompletedIndex++;
          if (unCompletedIndex == index) {
            return loadedTasks[i].task;
          }
        }
      }
      throw Error();
    } else {
      throw Error();
    }
  }

  void addNewFastTask(TextEditingController fastTaskTextEditingController) {
    if (state is TaskListLoadedState && fastTaskTextEditingController.text.isNotEmpty) {
      AnimatedTask fastTask = AnimatedTask(task: Task.empty(fastTaskTextEditingController.text), isAnimated: false);
      logger.info(
          'Add fast task with text: ${fastTaskTextEditingController.text}');
      fastTaskTextEditingController.clear();
      List<AnimatedTask> newLoadedTasks = List<AnimatedTask>.from(loadedTasks)..add(fastTask);

      List<Task> saveTaskList = newLoadedTasks.map((e) => e.task).toList();
      localRepo.saveLocalTasks(saveTaskList);
      _doServerRequest(
        () async {
          await globalRepo.postGlobalTask(fastTask.task);
        }
      );

      Cont.getIt.get<AppMetricaController>().reportEvent('Add new fast task');

      emit((state as TaskListLoadedState).copyWith(loadedTasks: newLoadedTasks));
    }
  }

  void deleteTask(Task toDeleteTask) {
    if (state is TaskListLoadedState) {
      int indexOfDeletingTask = loadedTasks.indexWhere((element) => element.task.id == toDeleteTask.id);
      List<AnimatedTask> newLoadedTasks = List<AnimatedTask>.from(loadedTasks)..removeAt(indexOfDeletingTask);

      List<Task> saveTaskList = newLoadedTasks.map((e) => e.task).toList();
      localRepo.saveLocalTasks(saveTaskList);
      _doServerRequest(
              () async {
            await globalRepo.deleteGlobalTask(toDeleteTask.id);
          }
      );

      Cont.getIt.get<AppMetricaController>().reportEvent('Delete task');

      emit((state as TaskListLoadedState).copyWith(loadedTasks: newLoadedTasks));
    }
  }

  void changeCompletedTaskVisible() {
    if (state is TaskListLoadedState) {
      emit((state as TaskListLoadedState).copyWith(isCompletedVisible: !isCompletedVisible));
      logger.info(
          'Change completed task visible to $isCompletedVisible');
    }
  }

  void changeTaskComplete({required Task chosenTask, Duration? animationDuration}) {
    if (state is TaskListLoadedState) {
      chosenTask = chosenTask.copyWith(done: !chosenTask.done, changedAt: DateTime.now().millisecondsSinceEpoch~/1000);
      int indexOfEditedTask = loadedTasks.indexWhere((element) => element.task.id == chosenTask.id);

      List<AnimatedTask> newLoadedTasks = List<AnimatedTask>.from(loadedTasks);
      if (animationDuration != null) {
        AnimatedTask animatedTask = AnimatedTask(task: chosenTask, isAnimated: true);
        newLoadedTasks[indexOfEditedTask] = animatedTask;
        taskAnimationStop(animatedTask, animationDuration);
      } else {
        newLoadedTasks[indexOfEditedTask] = AnimatedTask(task: chosenTask, isAnimated: false);
      }


      List<Task> saveTaskList = newLoadedTasks.map((e) => e.task).toList();
      localRepo.saveLocalTasks(saveTaskList);
      _doServerRequest(
              () async {
            await globalRepo.putGlobalTask(chosenTask.id, chosenTask);
          }
      );

      if (chosenTask.done) {
        Cont.getIt.get<AppMetricaController>().reportEvent('Task complete');
      } else {
        Cont.getIt.get<AppMetricaController>().reportEvent('Task incomplete');
      }
      logger.info(
          'Change task with index ${chosenTask.id} complete to: ${chosenTask.done}');

      emit((state as TaskListLoadedState).copyWith(loadedTasks: newLoadedTasks, inAnimation: false));
    }
  }

  void onAnimationStop() {
    if (state is TaskListLoadedState) {
      emit((state as TaskListLoadedState).copyWith(inAnimation: false));
    }
  }

  void onGetTaskFromEditor(Task editingTask) {
    if (state is TaskListLoadedState) {
      int indexOfEditedTask = loadedTasks.indexWhere((element) => element.task.id == editingTask.id);
      List<AnimatedTask> newLoadedTasks;
      if (indexOfEditedTask == -1) {
        newLoadedTasks = List<AnimatedTask>.from(loadedTasks)..add(AnimatedTask(task: editingTask, isAnimated: false));

        List<Task> saveTaskList = newLoadedTasks.map((e) => e.task).toList();
        localRepo.saveLocalTasks(saveTaskList);
        _doServerRequest(
                () async {
              await globalRepo.postGlobalTask(editingTask);
            }
        );
        Cont.getIt.get<AppMetricaController>().reportEvent('Add new editing task');
      } else {
        newLoadedTasks = List<AnimatedTask>.from(loadedTasks);
        newLoadedTasks[indexOfEditedTask] = AnimatedTask(task: editingTask, isAnimated: false);

        List<Task> saveTaskList = newLoadedTasks.map((e) => e.task).toList();
        localRepo.saveLocalTasks(saveTaskList);
        _doServerRequest(
                () async {
              await globalRepo.putGlobalTask(editingTask.id, editingTask);
            }
        );
      }
      emit((state as TaskListLoadedState).copyWith(loadedTasks: newLoadedTasks));
    }
  }

  Future<void> initialLoadTaskList() async {
    List<Task> localTasks;
    List<Task>? globalTasks;

    localTasks = localRepo.loadLocalTasks();
    globalTasks = await globalRepo.getGlobalTaskList();
    if (globalTasks != null) {
      localTasks = _checkLocalChanges(localTasks, globalTasks);
    }
    List<AnimatedTask> animatedTaskList = localTasks.map((e) => AnimatedTask(task: e, isAnimated: false)).toList();
    emit(TaskListState.loaded(loadedTasks: animatedTaskList, isCompletedVisible: false, inAnimation: false));
  }

  void taskAnimationStop(AnimatedTask animatedTask, Duration animationDuration) {
    Future.delayed(animationDuration, () {
      if (state is TaskListLoadedState) {
        int indexOfTask = loadedTasks.indexWhere((element) => element.task.id == animatedTask.task.id);
        if (indexOfTask != -1) {
          List<AnimatedTask> newLoadedTasks = List<AnimatedTask>.from(loadedTasks);
          newLoadedTasks[indexOfTask] = AnimatedTask(task: animatedTask.task, isAnimated: false);
          emit((state as TaskListLoadedState).copyWith(loadedTasks: newLoadedTasks));
        }
      }
    });
  }
}
