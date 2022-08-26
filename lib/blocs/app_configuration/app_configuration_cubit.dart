import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_configuration_state.dart';
part 'app_configuration_cubit.freezed.dart';

class AppConfigurationCubit extends Cubit<AppConfigurationState> {
  AppConfigurationCubit(double scale)
      : super(AppConfigurationState.loaded(
          isLightTheme: true,
          scale: scale,
        ));

  bool get isLightTheme => (state as AppConfigurationLoadedState).isLightTheme;
  double get appScale => (state as AppConfigurationLoadedState).scale;

  void changeTheme() {
    if (state is AppConfigurationLoadedState) {
      emit(AppConfigurationState.loaded(
          isLightTheme: !isLightTheme, scale: appScale));
    }
  }
}
