import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_todo/styles/app_colors.dart';
import 'package:school_todo/styles/app_fonts.dart';
import 'package:school_todo/ui/editor_page/widgets/importance_choose_widget.dart';
import 'package:school_todo/ui/editor_page/widgets/task_text_field_widget.dart';

import '../../models/task_model.dart';
import '../../navigation/navigation_controller.dart';
import 'widgets/clouse_button_widget.dart';
import 'widgets/deadline_choose_widget.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({Key? key, this.task}) : super(key: key);

  final Task? task;

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {

 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppLigthColors.backgroundPrimary,
      appBar: AppBar(
        scrolledUnderElevation: 4,
        elevation: 0,
        backgroundColor: AppLigthColors.backgroundPrimary,
        leading: SizedBox(
          height: 14,
          width: 14,
          child: IconButton(
              onPressed: () {
                context.read<NavigationController>().pop();
              },
              icon: const Icon(
                Icons.close,
                color: AppLigthColors.primary,
              )),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // сохранение
            },
            child: Text(
              "СОХРАНИТЬ",
              style: AppTextStyles.button.copyWith(
                color: AppLigthColors.blue,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
        child: ListView(
          children: const [
            TaskTextField(),
            SizedBox(height: 28),
            ImportanceChoose(),
            Divider(
              height: 0.5,
              color: AppLigthColors.separator,
            ),
            DeadlineChoose(),
            SizedBox(
              height: 24,
            ),
            Divider(
              height: 0.5,
              color: AppLigthColors.separator,
            ),
            ClouseButton(),
          ],
        ),
      ),
    );
  }
}




