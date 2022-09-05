import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/blocs/editing_task/editing_task_cubit.dart';

import '../../../blocs/app_configuration/app_configuration_cubit.dart';
import '../../../generated/l10n.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/app_fonts.dart';

class DeleteTaskButton extends StatelessWidget {
  const DeleteTaskButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToDoAppColors theme = Theme.of(context).extension<ToDoAppColors>()!;
    EditingTaskCubit editingTaskCubit =
        BlocProvider.of<EditingTaskCubit>(context);
    double scale = BlocProvider.of<AppConfigurationCubit>(context).appScale;
    return BlocBuilder<EditingTaskCubit, EditingTaskState>(
      builder: (context, state) {
        return SizedBox(
          height: 48 * scale,
          child: TextButton(
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            onPressed: () {
              editingTaskCubit.deleteTask(context);
            },
            child: Row(
              children: [
                SizedBox(
                  height: 24 * scale,
                  width: 24 * scale,
                  child: Transform.scale(
                    scale: scale,
                    child: Icon(
                      Icons.delete,
                      color: !editingTaskCubit.taskCanBeDeleted
                          ? theme.disable
                          : theme.red,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  S.of(context).editorDeleteButton,
                  style: AppTextStyles.body.copyWith(
                    color: !editingTaskCubit.taskCanBeDeleted
                        ? theme.disable
                        : theme.red,
                    fontSize: AppTextStyles.body.fontSize! * scale,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
