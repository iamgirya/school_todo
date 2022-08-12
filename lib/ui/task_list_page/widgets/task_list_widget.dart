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
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(right: 8, left: 8),
      color: AppLightColors.backgroundSecondary,
      child: BlocBuilder<TaskListCubit, TaskListState>(
        builder: (context, state) {
          TaskListCubit taskListCubit = BlocProvider.of<TaskListCubit>(context);
          if (state is TaskListReady) {
            int listLength = taskListCubit.isCompletedVisible
                ? taskListCubit.getLengthOfTaskList() + 3
                : taskListCubit.getUnLengthOfCompletedTaskList() + 3;
            return ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: listLength,
              itemBuilder: (context, index) {
                if (index == 0 || index == listLength - 1) {
                  return const SizedBox(
                    height: 8,
                  );
                } else if (index == listLength - 2) {
                  return const NewTaskCard();
                } else {
                  return DismissibleTaskCard(indexOfTask: index - 1);
                }
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
