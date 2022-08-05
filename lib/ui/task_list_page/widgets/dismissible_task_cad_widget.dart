import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/blocs/task_list/task_list_cubit.dart';

import 'task_card_widget.dart';

class DismissibleTaskCard extends StatefulWidget {
  const DismissibleTaskCard({Key? key, required this.i}) : super(key: key);

  final int i;

  @override
  State<DismissibleTaskCard> createState() => _DismissibleTaskCardState();
}

class _DismissibleTaskCardState extends State<DismissibleTaskCard> {
  final ValueNotifier<double> valueNotifier = ValueNotifier<double>(0);

  @override
  Widget build(BuildContext context) {
    TaskListCubit taskListCubit = BlocProvider.of<TaskListCubit>(context);
    return LayoutBuilder(builder: (context, constraints) {
      return Dismissible(
        key: Key(taskListCubit.getTask(widget.i).id.toString()),
        onDismissed: (direction) {
          taskListCubit.deleteTask(widget.i);
        },
        secondaryBackground: ValueListenableBuilder<double>(
          valueListenable: valueNotifier,
          builder: (context, date, _) {
            return ColoredBox(
              color: Colors.red,
              child: Container(
                height: 24,
                width: 24,
                padding: EdgeInsets.only(
                    right: constraints.maxWidth * date > 72
                        ? constraints.maxWidth * date - 48
                        : 24),
                alignment: Alignment.centerRight,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
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
        child: TaskCard(task: taskListCubit.getTask(widget.i)),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
