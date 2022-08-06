import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/blocs/editing_task/editing_task_cubit.dart';
import 'package:school_todo/blocs/editing_task/editing_task_state.dart';

import '../../../generated/l10n.dart';
import '../../../models/task_model.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/app_fonts.dart';

class ImportanceChoose extends StatelessWidget {
  const ImportanceChoose({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      width: Size.infinite.width,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).editorImportanceTitle,
              style: AppTextStyles.body,
            ),
            BlocBuilder<EditingTaskCubit, EditingTaskState>(
              buildWhen: (previous, current) => true,
              builder: ((context, state) {
                if (state is EditingTaskHasData) {
                  Task taskModel = state.editingTask;
                  EditingTaskCubit editingTaskCubit =
                      BlocProvider.of<EditingTaskCubit>(context);
                  return ButtonTheme(
                    child: DropdownButton(
                      // понять, как растянуть на всю линию и при этом оставить нормальное всплывающее меню
                      style: AppTextStyles.subhead
                          .copyWith(color: AppLigthColors.tertiary),
                      value: taskModel.importance,
                      icon: const SizedBox(),
                      underline: const SizedBox(),
                      isDense: true,
                      hint: Text(
                        S.of(context).editorImportanceBasic,
                        style: AppTextStyles.subhead
                            .copyWith(color: AppLigthColors.tertiary),
                      ),
                      items: [
                        DropdownMenuItem<Importance>(
                          value: Importance.basic,
                          child: Text(
                            S.of(context).editorImportanceBasic,
                            style: AppTextStyles.subhead
                                .copyWith(color: AppLigthColors.primary),
                          ),
                        ),
                        DropdownMenuItem<Importance>(
                          value: Importance.low,
                          child: Text(
                            S.of(context).editorImportanceLow,
                            style: AppTextStyles.subhead
                                .copyWith(color: AppLigthColors.primary),
                          ),
                        ),
                        DropdownMenuItem<Importance>(
                          value: Importance.important,
                          child: Text(
                            S.of(context).editorImportanceImportant,
                            style: AppTextStyles.subhead
                                .copyWith(color: AppLigthColors.red),
                          ),
                        ),
                      ],
                      onChanged: (Importance? value) {
                        editingTaskCubit.changeImportance(value);
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
