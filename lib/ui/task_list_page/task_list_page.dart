import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:school_todo/blocs/task_list/task_list_cubit.dart';
import 'package:school_todo/core/container_class.dart';
import 'package:school_todo/navigation/navigation_controller.dart';
import 'package:school_todo/navigation/root_names_container.dart';
import 'package:school_todo/styles/app_colors.dart';
import 'package:school_todo/ui/task_list_page/widgets/task_card_widget.dart';
import 'package:school_todo/ui/task_list_page/widgets/task_list_widget.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        TaskListCubit cubit = TaskListCubit();
        cubit.loadTaskList();
        return cubit;
      },
      child: Scaffold(
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
                  context
                      .read<NavigationController>()
                      .navigateTo(RouteNames.editorPage);
                },
                icon: const Icon(
                  Icons.close,
                  color: AppLigthColors.primary,
                )),
          ),
        ),
        body: const TaskList(),
      ),
    );
  }
}
