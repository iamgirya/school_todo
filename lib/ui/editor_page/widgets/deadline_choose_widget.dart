import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/blocs/editing_task/editing_task_cubit.dart';
import 'package:school_todo/blocs/editing_task/editing_task_state.dart';
import 'package:school_todo/core/container_class.dart';

import '../../../models/task_model.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/app_fonts.dart';

class DeadlineChoose extends StatelessWidget {
  const DeadlineChoose({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      width: Size.infinite.width,
      child: BlocBuilder<EditingTaskCubit, EditingTaskState>(
        buildWhen: (previous, current) => true,
        builder: (context, state) {
          if (state is EditingTaskHasData) {
            Task taskModel = state.editingTask;
            EditingTaskCubit editingTaskCubit =
                BlocProvider.of<EditingTaskCubit>(context);
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Сделать до",
                      style: AppTextStyles.body,
                    ),
                    GestureDetector(
                      onTap: () {
                        editingTaskCubit.onTapeOnDate(context);
                      },
                      child: Text(
                        Cont.convertUnixToStringDate(taskModel.deadline) ??
                            "Нет",
                        style: AppTextStyles.button.copyWith(
                          color: taskModel.deadline != null &&
                                  editingTaskCubit.switchValue
                              ? AppLigthColors.blue
                              : AppLigthColors.tertiary,
                        ),
                      ),
                    ),
                  ],
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                Switch(
                  value: editingTaskCubit.switchValue,
                  onChanged: (value) {
                    editingTaskCubit.changeSwitch(context);
                  },
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
