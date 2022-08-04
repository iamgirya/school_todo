import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/blocs/editing_task/editing_task_cubit.dart';
import 'package:school_todo/models/task_model.dart';

import '../../../blocs/editing_task/editing_task_state.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/app_fonts.dart';

class TaskTextField extends StatelessWidget {
  const TaskTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 104),
      child: Card(
        color: AppLigthColors.backgroundSecondary,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<EditingTaskCubit, EditingTaskState>(
            buildWhen: (previous, current) => false,
            builder: ((context, state) {
              if (state is EditingTaskHasData) {
                EditingTaskCubit editingTaskCubit = BlocProvider.of<EditingTaskCubit>(context);
                return TextField(
                  style: AppTextStyles.body,
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: null,
                  minLines: 2,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    hintText: "Что надо сделать...",
                    hintStyle: AppTextStyles.body
                        .copyWith(color: AppLigthColors.tertiary),
                    border: InputBorder.none,
                  ),
                  controller: editingTaskCubit.textController,
                );
              } else {
                return Container();
              }
            }),
          ),
        ),
      ),
    );
  }
}
