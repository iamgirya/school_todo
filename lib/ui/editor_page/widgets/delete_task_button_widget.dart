import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/blocs/editing_task/editing_task_cubit.dart';
import 'package:school_todo/blocs/editing_task/editing_task_state.dart';

import '../../../core/logger.dart';
import '../../../generated/l10n.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/app_fonts.dart';

class DeleteTaskButton extends StatelessWidget {
  const DeleteTaskButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditingTaskCubit, EditingTaskState>(
      buildWhen: (previous, current) => false,
      builder: (context, state) {
        return SizedBox(
          height: 48,
          child: TextButton(
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            onPressed: () {
              logger.info("Delete task");
              BlocProvider.of<EditingTaskCubit>(context).deleteTask(context);
            },
            child: Row(
              children: [
                const SizedBox(
                  height: 24,
                  width: 24,
                  child: Icon(
                    Icons.delete,
                    color: AppLightColors.red,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  S.of(context).editorDeleteButton,
                  style: AppTextStyles.body.copyWith(
                    color: AppLightColors.red,
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
