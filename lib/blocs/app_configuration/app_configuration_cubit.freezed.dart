// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_configuration_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppConfigurationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() loading,
    required TResult Function(bool isLightTheme, double scale) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? loading,
    TResult Function(bool isLightTheme, double scale)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? loading,
    TResult Function(bool isLightTheme, double scale)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppConfigurationErrorState value) error,
    required TResult Function(AppConfigurationLoadingState value) loading,
    required TResult Function(AppConfigurationLoadedState value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AppConfigurationErrorState value)? error,
    TResult Function(AppConfigurationLoadingState value)? loading,
    TResult Function(AppConfigurationLoadedState value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppConfigurationErrorState value)? error,
    TResult Function(AppConfigurationLoadingState value)? loading,
    TResult Function(AppConfigurationLoadedState value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppConfigurationStateCopyWith<$Res> {
  factory $AppConfigurationStateCopyWith(AppConfigurationState value,
          $Res Function(AppConfigurationState) then) =
      _$AppConfigurationStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$AppConfigurationStateCopyWithImpl<$Res>
    implements $AppConfigurationStateCopyWith<$Res> {
  _$AppConfigurationStateCopyWithImpl(this._value, this._then);

  final AppConfigurationState _value;
  // ignore: unused_field
  final $Res Function(AppConfigurationState) _then;
}

/// @nodoc
abstract class _$$AppConfigurationErrorStateCopyWith<$Res> {
  factory _$$AppConfigurationErrorStateCopyWith(
          _$AppConfigurationErrorState value,
          $Res Function(_$AppConfigurationErrorState) then) =
      __$$AppConfigurationErrorStateCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$$AppConfigurationErrorStateCopyWithImpl<$Res>
    extends _$AppConfigurationStateCopyWithImpl<$Res>
    implements _$$AppConfigurationErrorStateCopyWith<$Res> {
  __$$AppConfigurationErrorStateCopyWithImpl(
      _$AppConfigurationErrorState _value,
      $Res Function(_$AppConfigurationErrorState) _then)
      : super(_value, (v) => _then(v as _$AppConfigurationErrorState));

  @override
  _$AppConfigurationErrorState get _value =>
      super._value as _$AppConfigurationErrorState;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$AppConfigurationErrorState(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AppConfigurationErrorState implements AppConfigurationErrorState {
  const _$AppConfigurationErrorState({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'AppConfigurationState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppConfigurationErrorState &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$AppConfigurationErrorStateCopyWith<_$AppConfigurationErrorState>
      get copyWith => __$$AppConfigurationErrorStateCopyWithImpl<
          _$AppConfigurationErrorState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() loading,
    required TResult Function(bool isLightTheme, double scale) loaded,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? loading,
    TResult Function(bool isLightTheme, double scale)? loaded,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? loading,
    TResult Function(bool isLightTheme, double scale)? loaded,
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
    required TResult Function(AppConfigurationErrorState value) error,
    required TResult Function(AppConfigurationLoadingState value) loading,
    required TResult Function(AppConfigurationLoadedState value) loaded,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AppConfigurationErrorState value)? error,
    TResult Function(AppConfigurationLoadingState value)? loading,
    TResult Function(AppConfigurationLoadedState value)? loaded,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppConfigurationErrorState value)? error,
    TResult Function(AppConfigurationLoadingState value)? loading,
    TResult Function(AppConfigurationLoadedState value)? loaded,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AppConfigurationErrorState implements AppConfigurationState {
  const factory AppConfigurationErrorState({required final String message}) =
      _$AppConfigurationErrorState;

  String get message;
  @JsonKey(ignore: true)
  _$$AppConfigurationErrorStateCopyWith<_$AppConfigurationErrorState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AppConfigurationLoadingStateCopyWith<$Res> {
  factory _$$AppConfigurationLoadingStateCopyWith(
          _$AppConfigurationLoadingState value,
          $Res Function(_$AppConfigurationLoadingState) then) =
      __$$AppConfigurationLoadingStateCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AppConfigurationLoadingStateCopyWithImpl<$Res>
    extends _$AppConfigurationStateCopyWithImpl<$Res>
    implements _$$AppConfigurationLoadingStateCopyWith<$Res> {
  __$$AppConfigurationLoadingStateCopyWithImpl(
      _$AppConfigurationLoadingState _value,
      $Res Function(_$AppConfigurationLoadingState) _then)
      : super(_value, (v) => _then(v as _$AppConfigurationLoadingState));

  @override
  _$AppConfigurationLoadingState get _value =>
      super._value as _$AppConfigurationLoadingState;
}

/// @nodoc

class _$AppConfigurationLoadingState implements AppConfigurationLoadingState {
  const _$AppConfigurationLoadingState();

  @override
  String toString() {
    return 'AppConfigurationState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppConfigurationLoadingState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() loading,
    required TResult Function(bool isLightTheme, double scale) loaded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? loading,
    TResult Function(bool isLightTheme, double scale)? loaded,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? loading,
    TResult Function(bool isLightTheme, double scale)? loaded,
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
    required TResult Function(AppConfigurationErrorState value) error,
    required TResult Function(AppConfigurationLoadingState value) loading,
    required TResult Function(AppConfigurationLoadedState value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AppConfigurationErrorState value)? error,
    TResult Function(AppConfigurationLoadingState value)? loading,
    TResult Function(AppConfigurationLoadedState value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppConfigurationErrorState value)? error,
    TResult Function(AppConfigurationLoadingState value)? loading,
    TResult Function(AppConfigurationLoadedState value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AppConfigurationLoadingState implements AppConfigurationState {
  const factory AppConfigurationLoadingState() = _$AppConfigurationLoadingState;
}

/// @nodoc
abstract class _$$AppConfigurationLoadedStateCopyWith<$Res> {
  factory _$$AppConfigurationLoadedStateCopyWith(
          _$AppConfigurationLoadedState value,
          $Res Function(_$AppConfigurationLoadedState) then) =
      __$$AppConfigurationLoadedStateCopyWithImpl<$Res>;
  $Res call({bool isLightTheme, double scale});
}

/// @nodoc
class __$$AppConfigurationLoadedStateCopyWithImpl<$Res>
    extends _$AppConfigurationStateCopyWithImpl<$Res>
    implements _$$AppConfigurationLoadedStateCopyWith<$Res> {
  __$$AppConfigurationLoadedStateCopyWithImpl(
      _$AppConfigurationLoadedState _value,
      $Res Function(_$AppConfigurationLoadedState) _then)
      : super(_value, (v) => _then(v as _$AppConfigurationLoadedState));

  @override
  _$AppConfigurationLoadedState get _value =>
      super._value as _$AppConfigurationLoadedState;

  @override
  $Res call({
    Object? isLightTheme = freezed,
    Object? scale = freezed,
  }) {
    return _then(_$AppConfigurationLoadedState(
      isLightTheme: isLightTheme == freezed
          ? _value.isLightTheme
          : isLightTheme // ignore: cast_nullable_to_non_nullable
              as bool,
      scale: scale == freezed
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$AppConfigurationLoadedState implements AppConfigurationLoadedState {
  const _$AppConfigurationLoadedState(
      {required this.isLightTheme, required this.scale});

  @override
  final bool isLightTheme;
  @override
  final double scale;

  @override
  String toString() {
    return 'AppConfigurationState.loaded(isLightTheme: $isLightTheme, scale: $scale)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppConfigurationLoadedState &&
            const DeepCollectionEquality()
                .equals(other.isLightTheme, isLightTheme) &&
            const DeepCollectionEquality().equals(other.scale, scale));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLightTheme),
      const DeepCollectionEquality().hash(scale));

  @JsonKey(ignore: true)
  @override
  _$$AppConfigurationLoadedStateCopyWith<_$AppConfigurationLoadedState>
      get copyWith => __$$AppConfigurationLoadedStateCopyWithImpl<
          _$AppConfigurationLoadedState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() loading,
    required TResult Function(bool isLightTheme, double scale) loaded,
  }) {
    return loaded(isLightTheme, scale);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? loading,
    TResult Function(bool isLightTheme, double scale)? loaded,
  }) {
    return loaded?.call(isLightTheme, scale);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? loading,
    TResult Function(bool isLightTheme, double scale)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(isLightTheme, scale);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppConfigurationErrorState value) error,
    required TResult Function(AppConfigurationLoadingState value) loading,
    required TResult Function(AppConfigurationLoadedState value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AppConfigurationErrorState value)? error,
    TResult Function(AppConfigurationLoadingState value)? loading,
    TResult Function(AppConfigurationLoadedState value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppConfigurationErrorState value)? error,
    TResult Function(AppConfigurationLoadingState value)? loading,
    TResult Function(AppConfigurationLoadedState value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class AppConfigurationLoadedState implements AppConfigurationState {
  const factory AppConfigurationLoadedState(
      {required final bool isLightTheme,
      required final double scale}) = _$AppConfigurationLoadedState;

  bool get isLightTheme;
  double get scale;
  @JsonKey(ignore: true)
  _$$AppConfigurationLoadedStateCopyWith<_$AppConfigurationLoadedState>
      get copyWith => throw _privateConstructorUsedError;
}
