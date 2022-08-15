import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/blocs/task_list/task_list_cubit.dart';
import 'package:school_todo/styles/app_colors.dart';
import 'package:school_todo/styles/app_fonts.dart';

import '../../../generated/l10n.dart';

class NewTaskCard extends StatelessWidget {
  NewTaskCard({Key? key,}) : super(key: key);

  final TextEditingController fastTaskTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ToDoAppColors theme = Theme.of(context).extension<ToDoAppColors>()!;
    TaskListCubit taskListCubit = BlocProvider.of<TaskListCubit>(context);
    return ListTile(
      contentPadding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 24,
            width: 36,
          ),
          Expanded(
            child: TextField(
              controller: fastTaskTextEditingController,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(FocusNode());
                taskListCubit.addNewFastTask(fastTaskTextEditingController);
              },
              textInputAction: TextInputAction.done,
              textAlignVertical: TextAlignVertical.top,
              maxLines: 1,
              minLines: 1,
              cursorWidth: 2,
              cursorColor: theme.blue,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                hintText: S.of(context).taskListFastTaskHint,
                hintStyle:
                    AppTextStyles.body.copyWith(color: theme.tertiary),
                border: InputBorder.none,
              ),
              style: AppTextStyles.body,
            ),
          ),
        ],
      ),
    );
  }
}
