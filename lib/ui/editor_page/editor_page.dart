import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/blocs/editing_task/editing_task_cubit.dart';
import 'package:school_todo/core/container_class.dart';
import 'package:school_todo/styles/app_colors.dart';
import 'package:school_todo/styles/app_fonts.dart';
import 'package:school_todo/ui/editor_page/widgets/delete_task_button_widget.dart';
import 'package:school_todo/ui/editor_page/widgets/importance_choose_widget.dart';
import 'package:school_todo/ui/editor_page/widgets/task_text_field_widget.dart';

import '../../core/logger.dart';
import '../../generated/l10n.dart';
import '../../models/task_model.dart';
import '../../navigation/navigation_controller.dart';
import 'widgets/deadline_choose_widget.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({Key? key, this.editingTask}) : super(key: key);

  final Task? editingTask;

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  // костыль
  late void Function(BuildContext) saveTask;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        EditingTaskCubit editingTaskCubit = EditingTaskCubit(
          initTask: widget.editingTask,
          cubitsConnectorRepo: Cont.cubitsConnectorRepository,
        );
        saveTask = editingTaskCubit.saveTask;
        return editingTaskCubit;
      },
      child: Scaffold(
        backgroundColor: AppLightColors.backgroundPrimary,
        appBar: AppBar(
          scrolledUnderElevation: 4,
          elevation: 0,
          backgroundColor: AppLightColors.backgroundPrimary,
          leading: SizedBox(
            height: 14,
            width: 14,
            child: IconButton(
                onPressed: () {
                  context.read<NavigationController>().pop();
                },
                icon: const Icon(
                  Icons.close,
                  color: AppLightColors.primary,
                )),
          ),
          actions: [
            TextButton(
              onPressed: () {
                logger.info("Save task");
                // Вот здесь я должен получить Блок из провайдера через BlocProvider.of<EditingTaskCubit>(context);

                // вместо этого я использую вызов функции, записанную в переменную
                saveTask(context);
              },
              child: Text(
                S.of(context).editorSaveButton,
                style: AppTextStyles.button.copyWith(
                  color: AppLightColors.blue,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          child: ListView(
            children: const [
              TaskTextField(),
              SizedBox(height: 28),
              ImportanceChoose(),
              Divider(
                height: 0.5,
                color: AppLightColors.separator,
              ),
              DeadlineChoose(),
              SizedBox(
                height: 24,
              ),
              Divider(
                height: 0.5,
                color: AppLightColors.separator,
              ),
              DeleteTaskButton(),
            ],
          ),
        ),
      ),
    );
  }
}
