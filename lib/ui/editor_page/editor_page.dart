import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:school_todo/blocs/editing_task/editing_task_cubit.dart';
import 'package:school_todo/repositories/cubits_connector_repository.dart';
import 'package:school_todo/styles/app_colors.dart';
import 'package:school_todo/styles/app_fonts.dart';
import 'package:school_todo/ui/editor_page/widgets/delete_task_button_widget.dart';
import 'package:school_todo/ui/editor_page/widgets/importance_choose_widget.dart';
import 'package:school_todo/ui/editor_page/widgets/task_text_field_widget.dart';

import '../../blocs/editing_task/editing_task_state.dart';
import '../../core/logger.dart';
import '../../generated/l10n.dart';
import '../../models/task_model.dart';
import '../../navigation/navigation_controller.dart';
import 'widgets/deadline_choose_widget.dart';

class EditorPage extends StatelessWidget {
  const EditorPage({Key? key, this.editingTask}) : super(key: key);

  final Task? editingTask;

  @override
  Widget build(BuildContext context) {
    ToDoAppColors theme = Theme.of(context).extension<ToDoAppColors>()!;
    return BlocProvider(
      create: (context) {
        GetIt getIt = GetIt.instance;
        EditingTaskCubit editingTaskCubit = EditingTaskCubit(
          initTask: editingTask,
          cubitsConnectorRepo: getIt.get<ICubitsConnectorRepository>(),
        );
        return editingTaskCubit;
      },
      child: Scaffold(
        backgroundColor: theme.backgroundPrimary,
        appBar: AppBar(
          scrolledUnderElevation: 4,
          elevation: 0,
          backgroundColor: theme.backgroundPrimary,
          leading: SizedBox(
            height: 14,
            width: 14,
            child: IconButton(
                onPressed: () {
                  context.read<NavigationController>().pop();
                },
                icon: Icon(
                  Icons.close,
                  color: theme.primary,
                )),
          ),
          actions: [
            BlocBuilder<EditingTaskCubit, EditingTaskState>(
                builder: (context, snapshot) {
              return TextButton(
                onPressed: () {
                  logger.info("Save task");
                  BlocProvider.of<EditingTaskCubit>(context).saveTask(context);
                },
                child: Text(
                  S.of(context).editorSaveButton,
                  style: AppTextStyles.button.copyWith(
                    color: theme.blue,
                  ),
                ),
              );
            }),
          ],
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          child: ListView(
            children: [
              const TaskTextField(),
              const SizedBox(height: 28),
              const ImportanceChoose(),
              Divider(
                height: 0.5,
                color: theme.separator,
              ),
              const DeadlineChoose(),
              const SizedBox(
                height: 24,
              ),
              Divider(
                height: 0.5,
                color: theme.separator,
              ),
              const DeleteTaskButton(),
            ],
          ),
        ),
      ),
    );
  }
}
