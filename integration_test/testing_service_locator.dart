import 'package:mockito/mockito.dart';
import 'package:school_todo/core/container_class.dart';
import 'package:school_todo/core/device_id_holder.dart';
import 'package:school_todo/models/task_model.dart';
import 'package:school_todo/repositories/cubits_connector_repository.dart';
import 'package:school_todo/repositories/local_task_repository.dart';
import 'package:school_todo/core/app_metrica_controller.dart';
import 'package:school_todo/repositories/task_list_repository.dart';

import '../test/cubits_test/task_list_cubit_test.mocks.dart';

Future<void> initTestingServiceLocator() async {
  //репозитории

  Cont.getIt.registerSingleton<ICubitsConnectorRepository>(
      SimpleCubitsConnectorRepository());

  ILocalTaskSavesRepository localRepo = FakeILocalTaskSavesRepository();
  Cont.getIt.registerSingleton<ILocalTaskSavesRepository>(localRepo);

  ITaskSavesRepository taskListRepository = MockITaskSavesRepository();
  Cont.getIt.registerSingleton<ITaskSavesRepository>(taskListRepository);
  when(taskListRepository.loadActualTaskList())
      .thenAnswer((_) => Future(() => []));

  //айди устройства
  DeviceIdHolder deviceIdHolder = DeviceIdHolder();
  deviceIdHolder.readDeviceId();
  Cont.getIt.registerSingleton<DeviceIdHolder>(deviceIdHolder);

  //Аппметрика
  AppMetricaController appMetricaController = AppMetricaController();
  Cont.getIt.registerSingleton<AppMetricaController>(appMetricaController);
}

class FakeILocalTaskSavesRepository extends Fake
    implements ILocalTaskSavesRepository {
  @override
  Task loadLocalTask(String? id) {
    return Task.empty(null);
  }
}
