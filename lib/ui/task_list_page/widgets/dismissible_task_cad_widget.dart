import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/blocs/task_list/task_list_cubit.dart';
import 'package:school_todo/models/task_model.dart';

import '../../../blocs/app_configuration/app_configuration_cubit.dart';
import '../../../core/logger.dart';
import 'task_card_widget.dart';

class DismissibleTaskCard extends StatefulWidget {
  const DismissibleTaskCard({Key? key, required this.indexOfTask})
      : super(key: key);

  final int indexOfTask;

  @override
  State<DismissibleTaskCard> createState() => _DismissibleTaskCardState();
}

class _DismissibleTaskCardState extends State<DismissibleTaskCard>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<double> valueNotifier = ValueNotifier<double>(0);
  final animationDuration = const Duration(milliseconds: 500);
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: animationDuration,
      vsync: this,
      value: 0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TaskListCubit taskListCubit = BlocProvider.of<TaskListCubit>(context);

    if (!taskListCubit.isTaskVisibleOnIndex(widget.indexOfTask)) {
      return const SizedBox();
    } else {
      taskListCubit.configureAnimation(
          widget.indexOfTask, _animationController);
      Task chosenTask = taskListCubit.getTask(widget.indexOfTask);

      return LayoutBuilder(builder: (context, constraints) {
        double scale = BlocProvider.of<AppConfigurationCubit>(context).appScale;
        return Dismissible(
          key: Key(chosenTask.id.toString()),
          confirmDismiss: (direction) async {
            if (direction.name == 'endToStart') {
              logger.info('Delete task with index: ${chosenTask.id}');
              return true;
            } else {
              if (taskListCubit.isCompletedVisible) {
                taskListCubit.changeTaskComplete(chosenTask: chosenTask);
                return false;
              } else {
                taskListCubit.changeTaskComplete(
                    chosenTask: chosenTask,
                    animationDuration: animationDuration);
                return true;
              }
            }
          },
          resizeDuration: animationDuration,
          onDismissed: (direction) {
            if (direction.name == 'endToStart') {
              taskListCubit.deleteTask(chosenTask);
            }
          },
          secondaryBackground: ValueListenableBuilder<double>(
            valueListenable: valueNotifier,
            builder: (context, date, _) {
              return ColoredBox(
                color: Colors.red,
                child: Container(
                  height: 24 * scale,
                  width: 24 * scale,
                  padding: EdgeInsets.only(
                      right: constraints.maxWidth * date > 72
                          ? constraints.maxWidth * date - 48
                          : 24),
                  alignment: Alignment.centerRight,
                  child: Transform.scale(
                    scale: scale,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
          background: ValueListenableBuilder<double>(
            valueListenable: valueNotifier,
            builder: (context, date, _) {
              return ColoredBox(
                color: Colors.green,
                child: Container(
                  height: 24,
                  width: 24,
                  padding: EdgeInsets.only(
                      left: constraints.maxWidth * date > 72
                          ? constraints.maxWidth * date - 48
                          : 24),
                  alignment: Alignment.centerLeft,
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
          onUpdate: (details) {
            valueNotifier.value = details.progress;
          },
          child: TaskCard(
            task: chosenTask,
            animationController: _animationController,
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
