import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceIdHolder {
  String? _deviceId;

  String get getDeviceId => _deviceId ?? 'Unknown device';

  Future<void> readDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      _deviceId = iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      _deviceId = androidDeviceInfo.id; // unique ID on Android
    }
  }
}
