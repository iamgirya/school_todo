import 'package:get_it/get_it.dart';
import 'package:school_todo/repositories/global_task_repository.dart';

import '../repositories/cubits_connector_repository.dart';
import '../repositories/local_task_repository.dart';
import 'device_id_holder.dart';

Future<void> initServiceLocator() async {
  GetIt getIt = GetIt.instance;

  //репозитории
  getIt.registerSingleton<IGlobalTaskSavesRepository>(GlobalTaskSavesRepository());

  getIt.registerSingleton<ICubitsConnectorRepository>(SimpleCubitsConnectorRepository());

  ILocalTaskSavesRepository localRepo = HiveLocalTaskSavesRepository();
  await localRepo.initLocalTaskSavesRepository();
  getIt.registerSingleton<ILocalTaskSavesRepository>(localRepo);

  //айди устройства
  DeviceIdHolder deviceIdHolder = DeviceIdHolder();
  deviceIdHolder.readDeviceId();
  getIt.registerSingleton<DeviceIdHolder>(deviceIdHolder);
}