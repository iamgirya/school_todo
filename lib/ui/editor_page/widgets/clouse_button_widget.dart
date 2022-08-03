import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:school_todo/blocs/editing_task_cubit.dart';
import 'package:school_todo/blocs/editing_task_state.dart';
import 'package:school_todo/navigation/navigation_controller.dart';

import '../../../models/task_model.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/app_fonts.dart';

class ClouseButton extends StatelessWidget {
  const ClouseButton({
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
                  // диалог подтверждения
                  BlocProvider.of<EditingTaskCubit>(context).deleteTask(context);
                },
                child: Row(
                  children: [
                    const SizedBox(
                      height: 24,
                      width: 24,
                      child: Icon(
                        Icons.delete,
                        color: AppLigthColors.red,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Удалить",
                      style: AppTextStyles.body.copyWith(
                        color: AppLigthColors.red,
                      ),
                    )
                  ],
                ),
              ));
        });
  }
}
