import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/blocs/editing_task/editing_task_cubit.dart';

import '../../../generated/l10n.dart';
import '../../../models/task_model.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/app_fonts.dart';

class DeadlineChoose extends StatelessWidget {
  const DeadlineChoose({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToDoAppColors theme = Theme.of(context).extension<ToDoAppColors>()!;
    return SizedBox(
      height: 72,
      child: BlocBuilder<EditingTaskCubit, EditingTaskState>(
        builder: (context, state) {
          if (state is EditingTaskLoadedState) {
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
                    Text(
                      S.of(context).editorDeadlineTitle,
                      style: AppTextStyles.body,
                    ),
                    if (taskModel.deadline != null)
                      GestureDetector(
                        onTap: () {
                          editingTaskCubit.onTapeOnDate(context);
                        },
                        child: Text(
                          taskModel.getConvertUnixToStringDate() ??
                              S.of(context).noWord,
                          style: AppTextStyles.button.copyWith(
                            color: taskModel.deadline != null &&
                                    editingTaskCubit.switchValue
                                ? theme.blue
                                : theme.tertiary,
                          ),
                        ),
                      ),
                  ],
                ),
                const Spacer(),
                Switch(
                  key: const Key('switchKey'),
                  activeColor: theme.blue,
                  activeTrackColor: theme.blue!.withOpacity(0.3),
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
