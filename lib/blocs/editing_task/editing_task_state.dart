part of 'editing_task_cubit.dart';

@freezed
class EditingTaskState with _$EditingTaskState {
  const factory EditingTaskState.error({required String message}) =
      EditingTaskErrorState;
  const factory EditingTaskState.loading() = EditingTaskLoadingState;
  const factory EditingTaskState.loaded({
    required Task editingTask,
    required bool switchValue,
    required bool taskCanBeDeleted,
  }) = EditingTaskLoadedState;
}
