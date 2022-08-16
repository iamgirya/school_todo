part of 'editing_task_cubit.dart';

@freezed
class EditingTaskState with _$EditingTaskState {
  const factory EditingTaskState.error({
    required String message
  }) = EditingTaskErrorState;
  const factory EditingTaskState.loading() = EditingTaskLoadingState;
  const factory EditingTaskState.loaded({
    required Task editingTask,
    required bool switchValue,
    required bool taskCanBeDeleted,
  }) = EditingTaskLoadedState;
}

// @immutable
// abstract class EditingTaskState  {
// }
//
// class EditingTaskError extends EditingTaskState {
//   final String message;
//
//   EditingTaskError({required this.message});
// }
//
// class EditingTaskHasData extends EditingTaskState {
//   final Task editingTask;
//
//   EditingTaskHasData({required this.editingTask});
// }
//
// class EditingTaskWaitingChanges extends EditingTaskHasData {
//
//   EditingTaskWaitingChanges({required Task editingTask}) : super(editingTask: editingTask);
// }
//
// class EditingTaskReady extends EditingTaskHasData {
//
//   EditingTaskReady({required Task editingTask}) : super(editingTask: editingTask);
// }