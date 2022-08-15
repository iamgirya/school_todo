import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/blocs/editing_task/editing_task_cubit.dart';
import 'package:school_todo/repositories/cubits_connector_repository.dart';
import 'package:school_todo/styles/app_colors.dart';
import 'package:school_todo/styles/app_fonts.dart';
import 'package:school_todo/ui/editor_page/widgets/delete_task_button_widget.dart';
import 'package:school_todo/ui/editor_page/widgets/importance_choose_widget.dart';
import 'package:school_todo/ui/editor_page/widgets/task_text_field_widget.dart';

import '../../blocs/editing_task/editing_task_state.dart';
import '../../core/container_class.dart';
import '../../generated/l10n.dart';
import '../../models/task_model.dart';
import '../../navigation/navigation_controller.dart';
import 'widgets/deadline_choose_widget.dart';

class EditorPage extends StatelessWidget {
  EditorPage({Key? key, this.editingTask}) : super(key: key);

  final Task? editingTask;
  final TextEditingController taskTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ToDoAppColors theme = Theme.of(context).extension<ToDoAppColors>()!;
    return BlocProvider(
      create: (context) {
        EditingTaskCubit editingTaskCubit = EditingTaskCubit(
          initTask: editingTask,
          cubitsConnectorRepo: Cont.getIt.get<ICubitsConnectorRepository>(),
        );
        if (editingTask != null) {
          taskTextEditingController.text = editingTask!.text;
        }
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
                  BlocProvider.of<EditingTaskCubit>(context).saveTask(context, taskTextEditingController.text);
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
              TaskTextField(taskTextEditingController: taskTextEditingController,),
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
