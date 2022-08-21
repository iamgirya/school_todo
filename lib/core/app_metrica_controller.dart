import 'package:appmetrica_plugin/appmetrica_plugin.dart';

class AppMetricaController {
  bool isActivated = false;

  Future<void> initAppMetric() async {
    await AppMetrica.activate(const AppMetricaConfig('cf303739-8f4b-4b02-8f9f-c25c437db3a9', logs: true));
    isActivated = true;
  }

  void reportEvent(String text) {
    if (isActivated) {
      AppMetrica.reportEvent(text);
    }
  }

  void reportEventWithMap(String text, Map<String, Object>? map) {
    if (isActivated) {
      AppMetrica.reportEventWithMap(text, map);
    }
  }
}