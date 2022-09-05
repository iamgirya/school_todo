import 'package:school_todo/core/app_metrica_controller.dart';
import 'package:school_todo/repositories/global_task_repository.dart';
import 'package:school_todo/repositories/task_list_repository.dart';

import '../repositories/cubits_connector_repository.dart';
import '../repositories/local_task_repository.dart';
import 'container_class.dart';
import 'device_id_holder.dart';

Future<void> initServiceLocator() async {
  //репозитории
  GlobalTaskSavesRepository globalRepo = GlobalTaskSavesRepositoryImpl();
  Cont.getIt.registerSingleton<GlobalTaskSavesRepository>(globalRepo);

  Cont.getIt.registerSingleton<CubitsConnectorRepository>(
      CubitsConnectorRepositoryImpl());

  LocalTaskSavesRepository localRepo = LocalTaskSavesRepositoryHiveImpl();
  await localRepo.initLocalTaskSavesRepository();
  Cont.getIt.registerSingleton<LocalTaskSavesRepository>(localRepo);

  Cont.getIt.registerSingleton<TaskSavesRepository>(
      TaskListRepositoryImpl(localRepo: localRepo, globalRepo: globalRepo));

  //айди устройства
  DeviceIdHolder deviceIdHolder = DeviceIdHolder();
  deviceIdHolder.readDeviceId();
  Cont.getIt.registerSingleton<DeviceIdHolder>(deviceIdHolder);

  //Аппметрика
  AppMetricaController appMetricaController = AppMetricaController();
  appMetricaController.initAppMetric();
  Cont.getIt.registerSingleton<AppMetricaController>(appMetricaController);
}
