import 'package:school_todo/repositories/global_task_repository.dart';

import '../repositories/cubits_connector_repository.dart';
import '../repositories/local_task_repository.dart';
import 'container_class.dart';
import 'device_id_holder.dart';

Future<void> initServiceLocator() async {
  //репозитории
  Cont.getIt.registerSingleton<IGlobalTaskSavesRepository>(GlobalTaskSavesRepository());

  Cont.getIt.registerSingleton<ICubitsConnectorRepository>(SimpleCubitsConnectorRepository());

  ILocalTaskSavesRepository localRepo = HiveLocalTaskSavesRepository();
  await localRepo.initLocalTaskSavesRepository();
  Cont.getIt.registerSingleton<ILocalTaskSavesRepository>(localRepo);

  //айди устройства
  DeviceIdHolder deviceIdHolder = DeviceIdHolder();
  deviceIdHolder.readDeviceId();
  Cont.getIt.registerSingleton<DeviceIdHolder>(deviceIdHolder);
}