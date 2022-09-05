import 'package:mockito/mockito.dart';
import 'package:school_todo/core/container_class.dart';
import 'package:school_todo/core/device_id_holder.dart';
import 'package:school_todo/models/task_model.dart';
import 'package:school_todo/repositories/cubits_connector_repository.dart';
import 'package:school_todo/repositories/local_task_repository.dart';
import 'package:school_todo/core/app_metrica_controller.dart';
import 'package:school_todo/repositories/task_list_repository.dart';

import '../test/mocks/fake_task_saves_repository.dart';

Future<void> initTestingServiceLocator() async {
  //репозитории
  Cont.getIt.registerSingleton<CubitsConnectorRepository>(
      CubitsConnectorRepositoryImpl());

  LocalTaskSavesRepository localRepo = FakeILocalTaskSavesRepository();
  Cont.getIt.registerSingleton<LocalTaskSavesRepository>(localRepo);

  TaskSavesRepository taskListRepository = FakeTaskSavesRepository();
  Cont.getIt.registerSingleton<TaskSavesRepository>(taskListRepository);

  //айди устройства
  DeviceIdHolder deviceIdHolder = DeviceIdHolder();
  deviceIdHolder.readDeviceId();
  Cont.getIt.registerSingleton<DeviceIdHolder>(deviceIdHolder);

  //Аппметрика
  AppMetricaController appMetricaController = AppMetricaController();
  Cont.getIt.registerSingleton<AppMetricaController>(appMetricaController);
}

class FakeILocalTaskSavesRepository extends Fake
    implements LocalTaskSavesRepository {
  @override
  Task loadLocalTask(String? id) {
    return Task.empty(null);
  }
}
