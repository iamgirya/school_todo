import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/blocs/editing_task/editing_task_cubit.dart';

import '../../../generated/l10n.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/app_fonts.dart';

class TaskTextField extends StatelessWidget {
  const TaskTextField({
    Key? key,
    required this.taskTextEditingController,
  }) : super(key: key);

  final TextEditingController taskTextEditingController;

  @override
  Widget build(BuildContext context) {
    ToDoAppColors theme = Theme.of(context).extension<ToDoAppColors>()!;
    EditingTaskCubit editingTaskCubit =
        BlocProvider.of<EditingTaskCubit>(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 104),
      child: Card(
        color: theme.backgroundSecondary,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            style: AppTextStyles.body,
            textAlignVertical: TextAlignVertical.top,
            maxLines: null,
            minLines: 2,
            cursorWidth: 2,
            cursorColor: theme.blue,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              hintText: S.of(context).editorTextTaskHint,
              hintStyle: AppTextStyles.body.copyWith(color: theme.tertiary),
              border: InputBorder.none,
            ),
            controller: taskTextEditingController,
            onChanged: editingTaskCubit.onStartOrEndInput,
          ),
        ),
      ),
    );
  }
}
