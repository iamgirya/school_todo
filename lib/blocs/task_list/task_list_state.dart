part of 'task_list_cubit.dart';

@freezed
class TaskListState with _$TaskListState {
  const factory TaskListState.error({required String message}) =
      TaskListErrorState;
  const factory TaskListState.initial() = TaskListInitialState;
  const factory TaskListState.loading() = TaskListLoadingState;
  const factory TaskListState.loaded({
    required List<AnimatedTask> loadedTasks,
    required bool isCompletedVisible,
    required bool inAnimation,
    required bool isTaskSorting,
  }) = TaskListLoadedState;
}

// class TaskListError extends TaskListState {
//   final String message;
//
//   TaskListError({required this.message});
// }
//
// class TaskListOnStart extends TaskListState {}
//
// class TaskListLoadError extends TaskListState {}
//
// class TaskListHasData extends TaskListState {
//
//   final List<Task> loadedTasks;
//   final ILocalTaskSavesRepository localRepo;
//   final IGlobalTaskSavesRepository globalRepo;
//   final ICubitsConnectorRepository cubitsConnectorRepo;
//   final bool isCompletedVisible;
//
//   const TaskListHasData({required this.loadedTasks});
// }
//
// class TaskListWaitingChanges extends TaskListHasData {
//   const TaskListWaitingChanges({required super.loadedTasks});
// }
//
// class TaskListReady extends TaskListHasData {
// //   const TaskListReady({required super.loadedTasks});
// }
