import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/core/app_metrica_controller.dart';
import 'package:school_todo/core/logger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:school_todo/repositories/task_list_repository.dart';

import '../../core/container_class.dart';
import '../../models/animated_task_model.dart';
import '../../models/importance_model.dart';
import '../../models/task_model.dart';

import '../../repositories/cubits_connector_repository.dart';

part 'task_list_state.dart';
part 'task_list_cubit.freezed.dart';

class TaskListCubit extends Cubit<TaskListState> {
  TaskListCubit(
      {required this.taskListRepository, required this.cubitsConnectorRepo})
      : super(const TaskListState.initial()) {
    cubitsConnectorRepo.setCallBackOnNewTask(onGetTaskFromEditor);
    cubitsConnectorRepo.setCallBackOnDeleteTask(deleteTask);
  }

  final ITaskSavesRepository taskListRepository;
  final ICubitsConnectorRepository cubitsConnectorRepo;

  List<AnimatedTask> get loadedTasks =>
      (state as TaskListLoadedState).loadedTasks;
  bool get isCompletedVisible =>
      (state as TaskListLoadedState).isCompletedVisible;
  bool get isListAnimated => (state as TaskListLoadedState).inAnimation;
  bool get isTaskSorting => (state as TaskListLoadedState).isTaskSorting;
  bool get isOffline => (state as TaskListLoadedState).isOffline;

  void _taskAnimationStop(
      AnimatedTask animatedTask, Duration animationDuration) {
    Future.delayed(animationDuration, () {
      if (state is TaskListLoadedState) {
        int indexOfTask = loadedTasks
            .indexWhere((element) => element.task.id == animatedTask.task.id);
        if (indexOfTask != -1) {
          List<AnimatedTask> newLoadedTasks =
              List<AnimatedTask>.from(loadedTasks);
          newLoadedTasks[indexOfTask] =
              newLoadedTasks[indexOfTask].copyWith(isAnimated: false);
          emit((state as TaskListLoadedState)
              .copyWith(loadedTasks: newLoadedTasks));
        }
      }
    });
  }

  void _checkOffline(bool nowOfflineMode) {
    if (!isOffline && nowOfflineMode) {
      emit((state as TaskListLoadedState).copyWith(isOffline: !isOffline));
    } else if (isOffline && !nowOfflineMode) {
      emit((state as TaskListLoadedState).copyWith(isOffline: !isOffline));
    }
  }

  int getLengthOfTaskList() {
    if (state is TaskListLoadedState) {
      return loadedTasks.length;
    }
    return 0;
  }

  int getLengthOfUnCompletedTaskList() {
    if (state is TaskListLoadedState) {
      return loadedTasks.where((element) => !element.task.done).length;
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

  void addNewFastTask(TextEditingController fastTaskTextEditingController) {
    if (state is TaskListLoadedState &&
        fastTaskTextEditingController.text.isNotEmpty) {
      AnimatedTask fastTask = AnimatedTask(
          task: Task.empty(fastTaskTextEditingController.text),
          isAnimated: true,
          isNeedToBeVisible: true);
      _taskAnimationStop(fastTask, const Duration(milliseconds: 500));
      fastTaskTextEditingController.clear();
      List<AnimatedTask> newLoadedTasks = List<AnimatedTask>.from(loadedTasks)
        ..add(fastTask);

      if (isTaskSorting) {
        newLoadedTasks = _getSortedAnimatedTaskList(newLoadedTasks);
      }

      taskListRepository
          .postChanges(newLoadedTasks, fastTask)
          .then((value) => _checkOffline(value));

      Cont.getIt.get<AppMetricaController>().reportEvent('Add new fast task');
      logger.info(
          'Add fast task with text: ${fastTaskTextEditingController.text}');

      emit(
          (state as TaskListLoadedState).copyWith(loadedTasks: newLoadedTasks));
    }
  }

  void deleteTask(Task toDeleteTask) {
    if (state is TaskListLoadedState) {
      int indexOfDeletingTask = loadedTasks
          .indexWhere((element) => element.task.id == toDeleteTask.id);
      List<AnimatedTask> newLoadedTasks = List<AnimatedTask>.from(loadedTasks)
        ..removeAt(indexOfDeletingTask);

      taskListRepository
          .deleteChanges(newLoadedTasks, toDeleteTask.id)
          .then((value) => _checkOffline(value));

      Cont.getIt.get<AppMetricaController>().reportEvent('Delete task');

      emit(
          (state as TaskListLoadedState).copyWith(loadedTasks: newLoadedTasks));
    }
  }

  void changeCompletedTaskVisible(Duration animationDuration) {
    if (state is TaskListLoadedState) {
      List<AnimatedTask> newAnimatedTaskList = loadedTasks.map((e) {
        if (e.task.done) {
          e = e.copyWith(
              isNeedToBeVisible: !isCompletedVisible, isAnimated: e.task.done);
          _taskAnimationStop(e, const Duration(milliseconds: 500));
          return e;
        } else {
          return e;
        }
      }).toList();

      emit((state as TaskListLoadedState)
          .copyWith(loadedTasks: newAnimatedTaskList));

      Future.delayed(animationDuration, () {
        emit((state as TaskListLoadedState)
            .copyWith(isCompletedVisible: !isCompletedVisible));
      });
      logger.info('Change completed task visible to $isCompletedVisible');
    }
  }

  void changeTaskComplete(
      {required Task chosenTask, Duration? animationDuration}) {
    if (state is TaskListLoadedState) {
      chosenTask = chosenTask.copyWith(
          done: !chosenTask.done,
          changedAt: DateTime.now().millisecondsSinceEpoch ~/ 1000);
      int indexOfEditedTask =
          loadedTasks.indexWhere((element) => element.task.id == chosenTask.id);

      List<AnimatedTask> newLoadedTasks = List<AnimatedTask>.from(loadedTasks);
      if (animationDuration != null) {
        AnimatedTask animatedTask = AnimatedTask(
            task: chosenTask,
            isAnimated: true,
            isNeedToBeVisible: !(!isCompletedVisible && chosenTask.done));
        newLoadedTasks[indexOfEditedTask] = animatedTask;
        _taskAnimationStop(animatedTask, animationDuration);
      } else {
        newLoadedTasks[indexOfEditedTask] = AnimatedTask(
            task: chosenTask,
            isAnimated: false,
            isNeedToBeVisible: !(!isCompletedVisible && chosenTask.done));
      }

      taskListRepository
          .putChanges(newLoadedTasks, newLoadedTasks[indexOfEditedTask].task.id,
              newLoadedTasks[indexOfEditedTask])
          .then((value) => _checkOffline(value));

      if (chosenTask.done) {
        Cont.getIt.get<AppMetricaController>().reportEvent('Task complete');
      } else {
        Cont.getIt.get<AppMetricaController>().reportEvent('Task incomplete');
      }
      logger.info(
          'Change task with index ${chosenTask.id} complete to: ${chosenTask.done}');

      emit((state as TaskListLoadedState)
          .copyWith(loadedTasks: newLoadedTasks, inAnimation: false));
    }
  }

  void onGetTaskFromEditor(Task editingTask) {
    if (state is TaskListLoadedState) {
      int indexOfEditedTask = loadedTasks
          .indexWhere((element) => element.task.id == editingTask.id);
      List<AnimatedTask> newLoadedTasks;
      if (indexOfEditedTask == -1) {
        AnimatedTask newTask = AnimatedTask(
            task: editingTask, isAnimated: true, isNeedToBeVisible: true);
        newLoadedTasks = List<AnimatedTask>.from(loadedTasks)..add(newTask);
        _taskAnimationStop(newTask, const Duration(milliseconds: 500));

        if (isTaskSorting) {
          newLoadedTasks = _getSortedAnimatedTaskList(newLoadedTasks);
        }

        taskListRepository
            .postChanges(newLoadedTasks, newTask)
            .then((value) => _checkOffline(value));

        Cont.getIt
            .get<AppMetricaController>()
            .reportEvent('Add new editing task');
      } else {
        newLoadedTasks = List<AnimatedTask>.from(loadedTasks);
        newLoadedTasks[indexOfEditedTask] =
            newLoadedTasks[indexOfEditedTask].copyWith(task: editingTask);

        if (isTaskSorting) {
          newLoadedTasks = _getSortedAnimatedTaskList(newLoadedTasks);
        }

        taskListRepository
            .putChanges(
                newLoadedTasks,
                newLoadedTasks[indexOfEditedTask].task.id,
                newLoadedTasks[indexOfEditedTask])
            .then((value) => _checkOffline(value));
      }
      emit(
          (state as TaskListLoadedState).copyWith(loadedTasks: newLoadedTasks));
    }
  }

  Future<void> initialLoadTaskList() async {
    List<Task> loadedTask = await taskListRepository.loadActualTaskList();

    List<AnimatedTask> animatedTaskList = loadedTask.map((e) {
      AnimatedTask animatedTask = AnimatedTask(
          task: e, isAnimated: !e.done, isNeedToBeVisible: !e.done);
      if (!e.done) {
        _taskAnimationStop(animatedTask, const Duration(milliseconds: 500));
      }
      return animatedTask;
    }).toList();

    emit(TaskListState.loaded(
      loadedTasks: animatedTaskList,
      isCompletedVisible: false,
      inAnimation: false,
      isTaskSorting:
          taskListRepository.loadConfiguration()['isTaskSorting'] ?? false,
      isOffline: false,
    ));

    _checkOffline(taskListRepository.isOffline);
  }

  bool isTaskVisibleOnIndex(int indexOfTask) {
    if (state is TaskListLoadedState) {
      if (loadedTasks[indexOfTask].isNeedToBeVisible ||
          !(!isCompletedVisible &&
              loadedTasks[indexOfTask].task.done &&
              !loadedTasks[indexOfTask].isAnimated)) {
        return true;
      }
    }
    return false;
  }

  void configureAnimation(
      int indexOfTask, AnimationController animationController) {
    if (state is TaskListLoadedState) {
      if (!isListAnimated && !loadedTasks[indexOfTask].isAnimated) {
        if (loadedTasks[indexOfTask].isNeedToBeVisible) {
          animationController.value = 1;
        } else {
          animationController.value = 0;
        }
      } else {
        if (loadedTasks[indexOfTask].isNeedToBeVisible) {
          if (animationController.value == 1) {
            animationController.value = 0;
          }
          animationController.animateTo(1);
        } else {
          animationController.animateTo(0);
        }
      }
    }
  }

  void changeTaskSorting() {
    if (state is TaskListLoadedState) {
      if (!isTaskSorting) {
        taskListRepository.saveConfiguration(isTaskSorting: true);
        emit((state as TaskListLoadedState).copyWith(
            loadedTasks: _getSortedAnimatedTaskList(), isTaskSorting: true));
      } else {
        taskListRepository.saveConfiguration(isTaskSorting: false);
        emit((state as TaskListLoadedState).copyWith(isTaskSorting: false));
      }
    }
  }

  List<AnimatedTask> _getSortedAnimatedTaskList(
      [List<AnimatedTask>? listToSort]) {
    if (state is TaskListLoadedState) {
      if (listToSort != null) {
        return List<AnimatedTask>.from(listToSort)
          ..sort((first, second) {
            int firstImportance = importanceToInt(first.task.importance);
            int secondImportance = importanceToInt(second.task.importance);
            return -firstImportance.compareTo(secondImportance);
          });
      } else {
        return List<AnimatedTask>.from(loadedTasks)
          ..sort((first, second) {
            int firstImportance = importanceToInt(first.task.importance);
            int secondImportance = importanceToInt(second.task.importance);
            return -firstImportance.compareTo(secondImportance);
          });
      }
    }
    return [];
  }
}
