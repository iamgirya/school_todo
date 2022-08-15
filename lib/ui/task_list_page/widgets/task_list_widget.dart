import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/blocs/task_list/task_list_cubit.dart';
import 'package:school_todo/blocs/task_list/task_list_state.dart';
import 'package:school_todo/styles/app_colors.dart';
import 'package:school_todo/ui/task_list_page/widgets/dismissible_task_cad_widget.dart';
import 'package:school_todo/ui/task_list_page/widgets/new_task_card_widget.dart';

class TaskList extends StatelessWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToDoAppColors theme = Theme.of(context).extension<ToDoAppColors>()!;
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(right: 8, left: 8),
      color: theme.backgroundSecondary,
      child: BlocBuilder<TaskListCubit, TaskListState>(
        builder: (context, state) {
          TaskListCubit taskListCubit = BlocProvider.of<TaskListCubit>(context);
          if (state is TaskListReady) {
            int listLength = taskListCubit.isCompletedVisible
                ? taskListCubit.getLengthOfTaskList()
                : taskListCubit.getUnLengthOfCompletedTaskList();
            return Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                for (int index = 0; index < listLength; index++)
                  DismissibleTaskCard(indexOfTask: index),
                NewTaskCard(),
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
