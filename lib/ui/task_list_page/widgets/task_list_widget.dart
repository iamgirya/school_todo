import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:school_todo/blocs/task_list/task_list_cubit.dart';
import 'package:school_todo/blocs/task_list/task_list_state.dart';
import 'package:school_todo/core/container_class.dart';
import 'package:school_todo/navigation/navigation_controller.dart';
import 'package:school_todo/navigation/root_names_container.dart';
import 'package:school_todo/styles/app_colors.dart';
import 'package:school_todo/ui/task_list_page/widgets/task_card_widget.dart';

class TaskList extends StatelessWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(right: 8, left: 8),
      color: AppLigthColors.backgroundSecondary,
      child: BlocBuilder<TaskListCubit, TaskListState>(
        builder: (context, state) {
          TaskListCubit taskListCubit = BlocProvider.of<TaskListCubit>(context);
          if (state is TaskListLoaded) {
            return ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                const SizedBox(
                  height: 8,
                ),
                //выгрузка из локального репозитория
                for (int i = 0; i < taskListCubit.getLengthOfTaskList(); i++)
                  Dismissible(
                    key: Key(taskListCubit.getTask(i).id.toString()),
                    onDismissed: (direction) {
                      taskListCubit.deleteTask(i);
                    },
                    // сделать нормальные свайпы
                    background: const ColoredBox(color: Colors.red),
                    secondaryBackground: const ColoredBox(color: Colors.blue),
                    child: TaskCard(task: taskListCubit.getTask(i)),
                  ),
                const SizedBox(
                  height: 8,
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}