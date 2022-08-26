// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'task_list_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TaskListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<AnimatedTask> loadedTasks,
            bool isCompletedVisible,
            bool inAnimation,
            bool isTaskSorting,
            bool isOffline)
        loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<AnimatedTask> loadedTasks, bool isCompletedVisible,
            bool inAnimation, bool isTaskSorting, bool isOffline)?
        loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<AnimatedTask> loadedTasks, bool isCompletedVisible,
            bool inAnimation, bool isTaskSorting, bool isOffline)?
        loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskListErrorState value) error,
    required TResult Function(TaskListInitialState value) initial,
    required TResult Function(TaskListLoadingState value) loading,
    required TResult Function(TaskListLoadedState value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TaskListErrorState value)? error,
    TResult Function(TaskListInitialState value)? initial,
    TResult Function(TaskListLoadingState value)? loading,
    TResult Function(TaskListLoadedState value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskListErrorState value)? error,
    TResult Function(TaskListInitialState value)? initial,
    TResult Function(TaskListLoadingState value)? loading,
    TResult Function(TaskListLoadedState value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskListStateCopyWith<$Res> {
  factory $TaskListStateCopyWith(
          TaskListState value, $Res Function(TaskListState) then) =
      _$TaskListStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$TaskListStateCopyWithImpl<$Res>
    implements $TaskListStateCopyWith<$Res> {
  _$TaskListStateCopyWithImpl(this._value, this._then);

  final TaskListState _value;
  // ignore: unused_field
  final $Res Function(TaskListState) _then;
}

/// @nodoc
abstract class _$$TaskListErrorStateCopyWith<$Res> {
  factory _$$TaskListErrorStateCopyWith(_$TaskListErrorState value,
          $Res Function(_$TaskListErrorState) then) =
      __$$TaskListErrorStateCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$$TaskListErrorStateCopyWithImpl<$Res>
    extends _$TaskListStateCopyWithImpl<$Res>
    implements _$$TaskListErrorStateCopyWith<$Res> {
  __$$TaskListErrorStateCopyWithImpl(
      _$TaskListErrorState _value, $Res Function(_$TaskListErrorState) _then)
      : super(_value, (v) => _then(v as _$TaskListErrorState));

  @override
  _$TaskListErrorState get _value => super._value as _$TaskListErrorState;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$TaskListErrorState(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TaskListErrorState implements TaskListErrorState {
  const _$TaskListErrorState({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'TaskListState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskListErrorState &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$TaskListErrorStateCopyWith<_$TaskListErrorState> get copyWith =>
      __$$TaskListErrorStateCopyWithImpl<_$TaskListErrorState>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<AnimatedTask> loadedTasks,
            bool isCompletedVisible,
            bool inAnimation,
            bool isTaskSorting,
            bool isOffline)
        loaded,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<AnimatedTask> loadedTasks, bool isCompletedVisible,
            bool inAnimation, bool isTaskSorting, bool isOffline)?
        loaded,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<AnimatedTask> loadedTasks, bool isCompletedVisible,
            bool inAnimation, bool isTaskSorting, bool isOffline)?
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
    required TResult Function(TaskListErrorState value) error,
    required TResult Function(TaskListInitialState value) initial,
    required TResult Function(TaskListLoadingState value) loading,
    required TResult Function(TaskListLoadedState value) loaded,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TaskListErrorState value)? error,
    TResult Function(TaskListInitialState value)? initial,
    TResult Function(TaskListLoadingState value)? loading,
    TResult Function(TaskListLoadedState value)? loaded,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskListErrorState value)? error,
    TResult Function(TaskListInitialState value)? initial,
    TResult Function(TaskListLoadingState value)? loading,
    TResult Function(TaskListLoadedState value)? loaded,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class TaskListErrorState implements TaskListState {
  const factory TaskListErrorState({required final String message}) =
      _$TaskListErrorState;

  String get message;
  @JsonKey(ignore: true)
  _$$TaskListErrorStateCopyWith<_$TaskListErrorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskListInitialStateCopyWith<$Res> {
  factory _$$TaskListInitialStateCopyWith(_$TaskListInitialState value,
          $Res Function(_$TaskListInitialState) then) =
      __$$TaskListInitialStateCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TaskListInitialStateCopyWithImpl<$Res>
    extends _$TaskListStateCopyWithImpl<$Res>
    implements _$$TaskListInitialStateCopyWith<$Res> {
  __$$TaskListInitialStateCopyWithImpl(_$TaskListInitialState _value,
      $Res Function(_$TaskListInitialState) _then)
      : super(_value, (v) => _then(v as _$TaskListInitialState));

  @override
  _$TaskListInitialState get _value => super._value as _$TaskListInitialState;
}

/// @nodoc

class _$TaskListInitialState implements TaskListInitialState {
  const _$TaskListInitialState();

  @override
  String toString() {
    return 'TaskListState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TaskListInitialState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<AnimatedTask> loadedTasks,
            bool isCompletedVisible,
            bool inAnimation,
            bool isTaskSorting,
            bool isOffline)
        loaded,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<AnimatedTask> loadedTasks, bool isCompletedVisible,
            bool inAnimation, bool isTaskSorting, bool isOffline)?
        loaded,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<AnimatedTask> loadedTasks, bool isCompletedVisible,
            bool inAnimation, bool isTaskSorting, bool isOffline)?
        loaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskListErrorState value) error,
    required TResult Function(TaskListInitialState value) initial,
    required TResult Function(TaskListLoadingState value) loading,
    required TResult Function(TaskListLoadedState value) loaded,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TaskListErrorState value)? error,
    TResult Function(TaskListInitialState value)? initial,
    TResult Function(TaskListLoadingState value)? loading,
    TResult Function(TaskListLoadedState value)? loaded,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskListErrorState value)? error,
    TResult Function(TaskListInitialState value)? initial,
    TResult Function(TaskListLoadingState value)? loading,
    TResult Function(TaskListLoadedState value)? loaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class TaskListInitialState implements TaskListState {
  const factory TaskListInitialState() = _$TaskListInitialState;
}

/// @nodoc
abstract class _$$TaskListLoadingStateCopyWith<$Res> {
  factory _$$TaskListLoadingStateCopyWith(_$TaskListLoadingState value,
          $Res Function(_$TaskListLoadingState) then) =
      __$$TaskListLoadingStateCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TaskListLoadingStateCopyWithImpl<$Res>
    extends _$TaskListStateCopyWithImpl<$Res>
    implements _$$TaskListLoadingStateCopyWith<$Res> {
  __$$TaskListLoadingStateCopyWithImpl(_$TaskListLoadingState _value,
      $Res Function(_$TaskListLoadingState) _then)
      : super(_value, (v) => _then(v as _$TaskListLoadingState));

  @override
  _$TaskListLoadingState get _value => super._value as _$TaskListLoadingState;
}

/// @nodoc

class _$TaskListLoadingState implements TaskListLoadingState {
  const _$TaskListLoadingState();

  @override
  String toString() {
    return 'TaskListState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TaskListLoadingState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<AnimatedTask> loadedTasks,
            bool isCompletedVisible,
            bool inAnimation,
            bool isTaskSorting,
            bool isOffline)
        loaded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<AnimatedTask> loadedTasks, bool isCompletedVisible,
            bool inAnimation, bool isTaskSorting, bool isOffline)?
        loaded,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<AnimatedTask> loadedTasks, bool isCompletedVisible,
            bool inAnimation, bool isTaskSorting, bool isOffline)?
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
    required TResult Function(TaskListErrorState value) error,
    required TResult Function(TaskListInitialState value) initial,
    required TResult Function(TaskListLoadingState value) loading,
    required TResult Function(TaskListLoadedState value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TaskListErrorState value)? error,
    TResult Function(TaskListInitialState value)? initial,
    TResult Function(TaskListLoadingState value)? loading,
    TResult Function(TaskListLoadedState value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskListErrorState value)? error,
    TResult Function(TaskListInitialState value)? initial,
    TResult Function(TaskListLoadingState value)? loading,
    TResult Function(TaskListLoadedState value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class TaskListLoadingState implements TaskListState {
  const factory TaskListLoadingState() = _$TaskListLoadingState;
}

/// @nodoc
abstract class _$$TaskListLoadedStateCopyWith<$Res> {
  factory _$$TaskListLoadedStateCopyWith(_$TaskListLoadedState value,
          $Res Function(_$TaskListLoadedState) then) =
      __$$TaskListLoadedStateCopyWithImpl<$Res>;
  $Res call(
      {List<AnimatedTask> loadedTasks,
      bool isCompletedVisible,
      bool inAnimation,
      bool isTaskSorting,
      bool isOffline});
}

/// @nodoc
class __$$TaskListLoadedStateCopyWithImpl<$Res>
    extends _$TaskListStateCopyWithImpl<$Res>
    implements _$$TaskListLoadedStateCopyWith<$Res> {
  __$$TaskListLoadedStateCopyWithImpl(
      _$TaskListLoadedState _value, $Res Function(_$TaskListLoadedState) _then)
      : super(_value, (v) => _then(v as _$TaskListLoadedState));

  @override
  _$TaskListLoadedState get _value => super._value as _$TaskListLoadedState;

  @override
  $Res call({
    Object? loadedTasks = freezed,
    Object? isCompletedVisible = freezed,
    Object? inAnimation = freezed,
    Object? isTaskSorting = freezed,
    Object? isOffline = freezed,
  }) {
    return _then(_$TaskListLoadedState(
      loadedTasks: loadedTasks == freezed
          ? _value._loadedTasks
          : loadedTasks // ignore: cast_nullable_to_non_nullable
              as List<AnimatedTask>,
      isCompletedVisible: isCompletedVisible == freezed
          ? _value.isCompletedVisible
          : isCompletedVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      inAnimation: inAnimation == freezed
          ? _value.inAnimation
          : inAnimation // ignore: cast_nullable_to_non_nullable
              as bool,
      isTaskSorting: isTaskSorting == freezed
          ? _value.isTaskSorting
          : isTaskSorting // ignore: cast_nullable_to_non_nullable
              as bool,
      isOffline: isOffline == freezed
          ? _value.isOffline
          : isOffline // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TaskListLoadedState implements TaskListLoadedState {
  const _$TaskListLoadedState(
      {required final List<AnimatedTask> loadedTasks,
      required this.isCompletedVisible,
      required this.inAnimation,
      required this.isTaskSorting,
      required this.isOffline})
      : _loadedTasks = loadedTasks;

  final List<AnimatedTask> _loadedTasks;
  @override
  List<AnimatedTask> get loadedTasks {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_loadedTasks);
  }

  @override
  final bool isCompletedVisible;
  @override
  final bool inAnimation;
  @override
  final bool isTaskSorting;
  @override
  final bool isOffline;

  @override
  String toString() {
    return 'TaskListState.loaded(loadedTasks: $loadedTasks, isCompletedVisible: $isCompletedVisible, inAnimation: $inAnimation, isTaskSorting: $isTaskSorting, isOffline: $isOffline)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskListLoadedState &&
            const DeepCollectionEquality()
                .equals(other._loadedTasks, _loadedTasks) &&
            const DeepCollectionEquality()
                .equals(other.isCompletedVisible, isCompletedVisible) &&
            const DeepCollectionEquality()
                .equals(other.inAnimation, inAnimation) &&
            const DeepCollectionEquality()
                .equals(other.isTaskSorting, isTaskSorting) &&
            const DeepCollectionEquality().equals(other.isOffline, isOffline));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_loadedTasks),
      const DeepCollectionEquality().hash(isCompletedVisible),
      const DeepCollectionEquality().hash(inAnimation),
      const DeepCollectionEquality().hash(isTaskSorting),
      const DeepCollectionEquality().hash(isOffline));

  @JsonKey(ignore: true)
  @override
  _$$TaskListLoadedStateCopyWith<_$TaskListLoadedState> get copyWith =>
      __$$TaskListLoadedStateCopyWithImpl<_$TaskListLoadedState>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<AnimatedTask> loadedTasks,
            bool isCompletedVisible,
            bool inAnimation,
            bool isTaskSorting,
            bool isOffline)
        loaded,
  }) {
    return loaded(
        loadedTasks, isCompletedVisible, inAnimation, isTaskSorting, isOffline);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<AnimatedTask> loadedTasks, bool isCompletedVisible,
            bool inAnimation, bool isTaskSorting, bool isOffline)?
        loaded,
  }) {
    return loaded?.call(
        loadedTasks, isCompletedVisible, inAnimation, isTaskSorting, isOffline);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<AnimatedTask> loadedTasks, bool isCompletedVisible,
            bool inAnimation, bool isTaskSorting, bool isOffline)?
        loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(loadedTasks, isCompletedVisible, inAnimation, isTaskSorting,
          isOffline);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskListErrorState value) error,
    required TResult Function(TaskListInitialState value) initial,
    required TResult Function(TaskListLoadingState value) loading,
    required TResult Function(TaskListLoadedState value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TaskListErrorState value)? error,
    TResult Function(TaskListInitialState value)? initial,
    TResult Function(TaskListLoadingState value)? loading,
    TResult Function(TaskListLoadedState value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskListErrorState value)? error,
    TResult Function(TaskListInitialState value)? initial,
    TResult Function(TaskListLoadingState value)? loading,
    TResult Function(TaskListLoadedState value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class TaskListLoadedState implements TaskListState {
  const factory TaskListLoadedState(
      {required final List<AnimatedTask> loadedTasks,
      required final bool isCompletedVisible,
      required final bool inAnimation,
      required final bool isTaskSorting,
      required final bool isOffline}) = _$TaskListLoadedState;

  List<AnimatedTask> get loadedTasks;
  bool get isCompletedVisible;
  bool get inAnimation;
  bool get isTaskSorting;
  bool get isOffline;
  @JsonKey(ignore: true)
  _$$TaskListLoadedStateCopyWith<_$TaskListLoadedState> get copyWith =>
      throw _privateConstructorUsedError;
}
