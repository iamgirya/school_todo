// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'editing_task_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EditingTaskState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() loading,
    required TResult Function(
            Task editingTask, bool switchValue, bool taskCanBeDeleted)
        loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? loading,
    TResult Function(Task editingTask, bool switchValue, bool taskCanBeDeleted)?
        loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? loading,
    TResult Function(Task editingTask, bool switchValue, bool taskCanBeDeleted)?
        loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EditingTaskErrorState value) error,
    required TResult Function(EditingTaskLoadingState value) loading,
    required TResult Function(EditingTaskLoadedState value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(EditingTaskErrorState value)? error,
    TResult Function(EditingTaskLoadingState value)? loading,
    TResult Function(EditingTaskLoadedState value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditingTaskErrorState value)? error,
    TResult Function(EditingTaskLoadingState value)? loading,
    TResult Function(EditingTaskLoadedState value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditingTaskStateCopyWith<$Res> {
  factory $EditingTaskStateCopyWith(
          EditingTaskState value, $Res Function(EditingTaskState) then) =
      _$EditingTaskStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$EditingTaskStateCopyWithImpl<$Res>
    implements $EditingTaskStateCopyWith<$Res> {
  _$EditingTaskStateCopyWithImpl(this._value, this._then);

  final EditingTaskState _value;
  // ignore: unused_field
  final $Res Function(EditingTaskState) _then;
}

/// @nodoc
abstract class _$$EditingTaskErrorStateCopyWith<$Res> {
  factory _$$EditingTaskErrorStateCopyWith(_$EditingTaskErrorState value,
          $Res Function(_$EditingTaskErrorState) then) =
      __$$EditingTaskErrorStateCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$$EditingTaskErrorStateCopyWithImpl<$Res>
    extends _$EditingTaskStateCopyWithImpl<$Res>
    implements _$$EditingTaskErrorStateCopyWith<$Res> {
  __$$EditingTaskErrorStateCopyWithImpl(_$EditingTaskErrorState _value,
      $Res Function(_$EditingTaskErrorState) _then)
      : super(_value, (v) => _then(v as _$EditingTaskErrorState));

  @override
  _$EditingTaskErrorState get _value => super._value as _$EditingTaskErrorState;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$EditingTaskErrorState(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EditingTaskErrorState implements EditingTaskErrorState {
  const _$EditingTaskErrorState({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'EditingTaskState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditingTaskErrorState &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$EditingTaskErrorStateCopyWith<_$EditingTaskErrorState> get copyWith =>
      __$$EditingTaskErrorStateCopyWithImpl<_$EditingTaskErrorState>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() loading,
    required TResult Function(
            Task editingTask, bool switchValue, bool taskCanBeDeleted)
        loaded,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? loading,
    TResult Function(Task editingTask, bool switchValue, bool taskCanBeDeleted)?
        loaded,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? loading,
    TResult Function(Task editingTask, bool switchValue, bool taskCanBeDeleted)?
        loaded,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EditingTaskErrorState value) error,
    required TResult Function(EditingTaskLoadingState value) loading,
    required TResult Function(EditingTaskLoadedState value) loaded,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(EditingTaskErrorState value)? error,
    TResult Function(EditingTaskLoadingState value)? loading,
    TResult Function(EditingTaskLoadedState value)? loaded,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditingTaskErrorState value)? error,
    TResult Function(EditingTaskLoadingState value)? loading,
    TResult Function(EditingTaskLoadedState value)? loaded,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class EditingTaskErrorState implements EditingTaskState {
  const factory EditingTaskErrorState({required final String message}) =
      _$EditingTaskErrorState;

  String get message;
  @JsonKey(ignore: true)
  _$$EditingTaskErrorStateCopyWith<_$EditingTaskErrorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditingTaskLoadingStateCopyWith<$Res> {
  factory _$$EditingTaskLoadingStateCopyWith(_$EditingTaskLoadingState value,
          $Res Function(_$EditingTaskLoadingState) then) =
      __$$EditingTaskLoadingStateCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EditingTaskLoadingStateCopyWithImpl<$Res>
    extends _$EditingTaskStateCopyWithImpl<$Res>
    implements _$$EditingTaskLoadingStateCopyWith<$Res> {
  __$$EditingTaskLoadingStateCopyWithImpl(_$EditingTaskLoadingState _value,
      $Res Function(_$EditingTaskLoadingState) _then)
      : super(_value, (v) => _then(v as _$EditingTaskLoadingState));

  @override
  _$EditingTaskLoadingState get _value =>
      super._value as _$EditingTaskLoadingState;
}

/// @nodoc

class _$EditingTaskLoadingState implements EditingTaskLoadingState {
  const _$EditingTaskLoadingState();

  @override
  String toString() {
    return 'EditingTaskState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditingTaskLoadingState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() loading,
    required TResult Function(
            Task editingTask, bool switchValue, bool taskCanBeDeleted)
        loaded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? loading,
    TResult Function(Task editingTask, bool switchValue, bool taskCanBeDeleted)?
        loaded,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? loading,
    TResult Function(Task editingTask, bool switchValue, bool taskCanBeDeleted)?
        loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EditingTaskErrorState value) error,
    required TResult Function(EditingTaskLoadingState value) loading,
    required TResult Function(EditingTaskLoadedState value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(EditingTaskErrorState value)? error,
    TResult Function(EditingTaskLoadingState value)? loading,
    TResult Function(EditingTaskLoadedState value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditingTaskErrorState value)? error,
    TResult Function(EditingTaskLoadingState value)? loading,
    TResult Function(EditingTaskLoadedState value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class EditingTaskLoadingState implements EditingTaskState {
  const factory EditingTaskLoadingState() = _$EditingTaskLoadingState;
}

/// @nodoc
abstract class _$$EditingTaskLoadedStateCopyWith<$Res> {
  factory _$$EditingTaskLoadedStateCopyWith(_$EditingTaskLoadedState value,
          $Res Function(_$EditingTaskLoadedState) then) =
      __$$EditingTaskLoadedStateCopyWithImpl<$Res>;
  $Res call({Task editingTask, bool switchValue, bool taskCanBeDeleted});

  $TaskCopyWith<$Res> get editingTask;
}

/// @nodoc
class __$$EditingTaskLoadedStateCopyWithImpl<$Res>
    extends _$EditingTaskStateCopyWithImpl<$Res>
    implements _$$EditingTaskLoadedStateCopyWith<$Res> {
  __$$EditingTaskLoadedStateCopyWithImpl(_$EditingTaskLoadedState _value,
      $Res Function(_$EditingTaskLoadedState) _then)
      : super(_value, (v) => _then(v as _$EditingTaskLoadedState));

  @override
  _$EditingTaskLoadedState get _value =>
      super._value as _$EditingTaskLoadedState;

  @override
  $Res call({
    Object? editingTask = freezed,
    Object? switchValue = freezed,
    Object? taskCanBeDeleted = freezed,
  }) {
    return _then(_$EditingTaskLoadedState(
      editingTask: editingTask == freezed
          ? _value.editingTask
          : editingTask // ignore: cast_nullable_to_non_nullable
              as Task,
      switchValue: switchValue == freezed
          ? _value.switchValue
          : switchValue // ignore: cast_nullable_to_non_nullable
              as bool,
      taskCanBeDeleted: taskCanBeDeleted == freezed
          ? _value.taskCanBeDeleted
          : taskCanBeDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $TaskCopyWith<$Res> get editingTask {
    return $TaskCopyWith<$Res>(_value.editingTask, (value) {
      return _then(_value.copyWith(editingTask: value));
    });
  }
}

/// @nodoc

class _$EditingTaskLoadedState implements EditingTaskLoadedState {
  const _$EditingTaskLoadedState(
      {required this.editingTask,
      required this.switchValue,
      required this.taskCanBeDeleted});

  @override
  final Task editingTask;
  @override
  final bool switchValue;
  @override
  final bool taskCanBeDeleted;

  @override
  String toString() {
    return 'EditingTaskState.loaded(editingTask: $editingTask, switchValue: $switchValue, taskCanBeDeleted: $taskCanBeDeleted)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditingTaskLoadedState &&
            const DeepCollectionEquality()
                .equals(other.editingTask, editingTask) &&
            const DeepCollectionEquality()
                .equals(other.switchValue, switchValue) &&
            const DeepCollectionEquality()
                .equals(other.taskCanBeDeleted, taskCanBeDeleted));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(editingTask),
      const DeepCollectionEquality().hash(switchValue),
      const DeepCollectionEquality().hash(taskCanBeDeleted));

  @JsonKey(ignore: true)
  @override
  _$$EditingTaskLoadedStateCopyWith<_$EditingTaskLoadedState> get copyWith =>
      __$$EditingTaskLoadedStateCopyWithImpl<_$EditingTaskLoadedState>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() loading,
    required TResult Function(
            Task editingTask, bool switchValue, bool taskCanBeDeleted)
        loaded,
  }) {
    return loaded(editingTask, switchValue, taskCanBeDeleted);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? loading,
    TResult Function(Task editingTask, bool switchValue, bool taskCanBeDeleted)?
        loaded,
  }) {
    return loaded?.call(editingTask, switchValue, taskCanBeDeleted);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? loading,
    TResult Function(Task editingTask, bool switchValue, bool taskCanBeDeleted)?
        loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(editingTask, switchValue, taskCanBeDeleted);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EditingTaskErrorState value) error,
    required TResult Function(EditingTaskLoadingState value) loading,
    required TResult Function(EditingTaskLoadedState value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(EditingTaskErrorState value)? error,
    TResult Function(EditingTaskLoadingState value)? loading,
    TResult Function(EditingTaskLoadedState value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditingTaskErrorState value)? error,
    TResult Function(EditingTaskLoadingState value)? loading,
    TResult Function(EditingTaskLoadedState value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class EditingTaskLoadedState implements EditingTaskState {
  const factory EditingTaskLoadedState(
      {required final Task editingTask,
      required final bool switchValue,
      required final bool taskCanBeDeleted}) = _$EditingTaskLoadedState;

  Task get editingTask;
  bool get switchValue;
  bool get taskCanBeDeleted;
  @JsonKey(ignore: true)
  _$$EditingTaskLoadedStateCopyWith<_$EditingTaskLoadedState> get copyWith =>
      throw _privateConstructorUsedError;
}
