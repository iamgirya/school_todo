import 'package:mockito/mockito.dart';
import 'package:school_todo/core/container_class.dart';
import 'package:school_todo/core/device_id_holder.dart';
import 'package:school_todo/repositories/cubits_connector_repository.dart';
import 'package:school_todo/repositories/local_task_repository.dart';
import 'package:school_todo/core/app_metrica_controller.dart';
import 'package:school_todo/repositories/global_task_repository.dart';

import '../test/mocks/fake_global_repository.dart';
import '../test/mocks/task_list_cubit_test.mocks.dart';


Future<void> initTestingServiceLocator() async {
  //репозитории
  Cont.getIt.registerSingleton<IGlobalTaskSavesRepository>(FakeGlobalRepository());

  Cont.getIt.registerSingleton<ICubitsConnectorRepository>(SimpleCubitsConnectorRepository());

  ILocalTaskSavesRepository localRepo = MockILocalTaskSavesRepository();
  Cont.getIt.registerSingleton<ILocalTaskSavesRepository>(localRepo);
  when(localRepo.loadLocalTasks()).thenAnswer((_) => []);

  //айди устройства
  DeviceIdHolder deviceIdHolder = DeviceIdHolder();
  deviceIdHolder.readDeviceId();
  Cont.getIt.registerSingleton<DeviceIdHolder>(deviceIdHolder);

  //Аппметрика
  AppMetricaController appMetricaController = AppMetricaController();
  Cont.getIt.registerSingleton<AppMetricaController>(appMetricaController);
}

