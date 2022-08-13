import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/blocs/editing_task/editing_task_cubit.dart';
import 'package:school_todo/blocs/editing_task/editing_task_state.dart';

import '../../../generated/l10n.dart';
import '../../../models/importance_model.dart';
import '../../../models/task_model.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/app_fonts.dart';

class ImportanceChoose extends StatelessWidget {
  const ImportanceChoose({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToDoAppColors theme = Theme.of(context).extension<ToDoAppColors>()!;
    return SizedBox(
      height: 72,
      width: Size.infinite.width,
      child: Align(
        alignment: Alignment.centerLeft,
        child: BlocBuilder<EditingTaskCubit, EditingTaskState>(
          buildWhen: (previous, current) => true,
          builder: ((context, state) {
            if (state is EditingTaskHasData) {
              Task taskModel = state.editingTask;
              EditingTaskCubit editingTaskCubit =
                  BlocProvider.of<EditingTaskCubit>(context);
              return PopupMenuButton<Importance>(
                  tooltip: "",
                  child: SizedBox(
                    width: Size.infinite.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).editorImportanceTitle,
                          style: AppTextStyles.body,
                        ),
                        Text(
                          taskModel.importance == Importance.basic
                              ? S.of(context).editorImportanceBasic
                              : taskModel.importance == Importance.low
                                  ? S.of(context).editorImportanceLow
                                  : S.of(context).editorImportanceImportant,
                          style: AppTextStyles.subhead.copyWith(
                              color:
                                  taskModel.importance == Importance.important
                                      ? theme.red
                                      : taskModel.importance == Importance.basic ? theme.tertiary : theme.primary),
                        ),
                      ],
                    ),
                  ),
                  onSelected: (Importance item) {
                    editingTaskCubit.changeImportance(item);
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<Importance>>[
                        PopupMenuItem<Importance>(
                          value: Importance.basic,
                          child: Text(
                            S.of(context).editorImportanceBasic,
                            style: AppTextStyles.subhead
                                .copyWith(color: theme.primary),
                          ),
                        ),
                        PopupMenuItem<Importance>(
                          value: Importance.low,
                          child: Text(
                            S.of(context).editorImportanceLow,
                            style: AppTextStyles.subhead
                                .copyWith(color: theme.primary),
                          ),
                        ),
                        PopupMenuItem<Importance>(
                          value: Importance.important,
                          child: Text(
                            S.of(context).editorImportanceImportant,
                            style: AppTextStyles.subhead
                                .copyWith(color: theme.red),
                          ),
                        ),
                      ]);
            } else {
              return Container();
            }
          }),
        ),
      ),
    );
  }
}
