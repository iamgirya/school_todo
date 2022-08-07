import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:school_todo/blocs/task_list/task_list_cubit.dart';
import 'package:school_todo/core/container_class.dart';
import 'package:school_todo/models/task_model.dart';
import 'package:school_todo/navigation/navigation_controller.dart';
import 'package:school_todo/navigation/root_names_container.dart';
import 'package:school_todo/styles/app_colors.dart';
import 'package:school_todo/styles/app_fonts.dart';

import '../../../core/logger.dart';
import '../../../generated/l10n.dart';

class NewTaskCard extends StatefulWidget {
  const NewTaskCard({Key? key}) : super(key: key);

  @override
  State<NewTaskCard> createState() => _NewTaskCardState();
}

class _NewTaskCardState extends State<NewTaskCard> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              controller: textEditingController,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(FocusNode());
                taskListCubit.addNewFastTask(textEditingController.text);
                textEditingController.clear();

                logger.info(
                    "Add fast task with text: ${textEditingController.text}");
              },
              textInputAction: TextInputAction.done,
              textAlignVertical: TextAlignVertical.top,
              maxLines: 1,
              minLines: 1,
              cursorWidth: 2,
              cursorColor: AppLightColors.blue,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                hintText: S.of(context).taskListFastTaskHint,
                hintStyle:
                    AppTextStyles.body.copyWith(color: AppLightColors.tertiary),
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
