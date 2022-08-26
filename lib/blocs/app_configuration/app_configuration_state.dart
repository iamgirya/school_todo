part of 'app_configuration_cubit.dart';

@freezed
class AppConfigurationState with _$AppConfigurationState {
  const factory AppConfigurationState.error({required String message}) =
      AppConfigurationErrorState;
  const factory AppConfigurationState.loading() = AppConfigurationLoadingState;
  const factory AppConfigurationState.loaded({
    required bool isLightTheme,
    required double scale,
  }) = AppConfigurationLoadedState;
}
