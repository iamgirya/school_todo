import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:school_todo/blocs/task_list/task_list_cubit.dart';
import 'package:school_todo/core/app_metrica_controller.dart';
import 'package:school_todo/core/container_class.dart';
import 'package:school_todo/core/device_id_holder.dart';
import 'package:school_todo/models/task_model.dart';
import 'package:school_todo/repositories/cubits_connector_repository.dart';
import 'package:school_todo/repositories/task_list_repository.dart';

import '../mocks/fake_task_saves_repository.dart';
import 'task_list_cubit_test.mocks.dart';

@GenerateMocks([AppMetricaController])
void main() {
  late CubitsConnectorRepository cubitsConnectorRepo;
  late TaskSavesRepository taskListRepository;
  late TaskListCubit taskListCubit;

  setUpAll(() async {
    DeviceIdHolder deviceIdHolder = DeviceIdHolder();
    await deviceIdHolder.readDeviceId();
    Cont.getIt.registerSingleton<DeviceIdHolder>(deviceIdHolder);
    Cont.getIt
        .registerSingleton<AppMetricaController>(MockAppMetricaController());
  });

  setUp(() async {
    taskListRepository = FakeTaskSavesRepository();
    cubitsConnectorRepo = CubitsConnectorRepositoryImpl();

    taskListCubit = TaskListCubit(
      taskListRepository: taskListRepository,
      cubitsConnectorRepo: cubitsConnectorRepo,
    );

    await taskListCubit.initialLoadTaskList();
  });

  test('Init cubit', () {
    final zero = taskListCubit.getLengthOfTaskList();

    expect(zero, 0);
  });

  test('Add fast tasks', () {
    TextEditingController textEditingController = TextEditingController();
    textEditingController.text = '123';
    taskListCubit.addNewFastTask(textEditingController);
    textEditingController.text = '456';
    taskListCubit.addNewFastTask(textEditingController);
    textEditingController.text = '789';
    taskListCubit.addNewFastTask(textEditingController);

    final count = taskListCubit.getLengthOfTaskList();
    final addedTask = taskListCubit.getTask(1);

    expect(count, 3);
    expect(textEditingController.text, '');
    expect(addedTask.text, '456');
    expect(addedTask.deadline, null);
    expect(addedTask.done, false);
  });

  test('Add, complete and delete task', () {
    TextEditingController textEditingController = TextEditingController();
    textEditingController.text = '123';
    taskListCubit.addNewFastTask(textEditingController);

    Task addedTask = taskListCubit.getTask(0);

    expect(taskListCubit.getLengthOfTaskList(), 1);
    expect(textEditingController.text, '');
    expect(addedTask.text, '123');
    expect(addedTask.deadline, null);
    expect(addedTask.done, false);

    taskListCubit.changeTaskComplete(chosenTask: addedTask);
    addedTask = taskListCubit.getTask(0);

    expect(taskListCubit.getLengthOfTaskList(), 1);
    expect(textEditingController.text, '');
    expect(addedTask.text, '123');
    expect(addedTask.deadline, null);
    expect(addedTask.done, true);

    taskListCubit.deleteTask(addedTask);
    expect(taskListCubit.getLengthOfTaskList(), 0);
  });

  test('Add and edit from connector task', () {
    TextEditingController textEditingController = TextEditingController();
    textEditingController.text = '123';
    taskListCubit.addNewFastTask(textEditingController);

    Task addedTask = taskListCubit.getTask(0);

    expect(taskListCubit.getLengthOfTaskList(), 1);
    expect(textEditingController.text, '');
    expect(addedTask.text, '123');
    expect(addedTask.deadline, null);
    expect(addedTask.done, false);

    cubitsConnectorRepo
        .addNewTask(addedTask.copyWith(deadline: 100, text: "456"));
    addedTask = taskListCubit.getTask(0);

    expect(textEditingController.text, '');
    expect(addedTask.text, '456');
    expect(addedTask.deadline, 100);
    expect(addedTask.done, false);
  });
}
