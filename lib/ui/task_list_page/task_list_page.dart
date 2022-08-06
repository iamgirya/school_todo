import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:school_todo/blocs/editing_task/editing_task_cubit.dart';
import 'package:school_todo/blocs/task_list/task_list_cubit.dart';
import 'package:school_todo/core/container_class.dart';
import 'package:school_todo/navigation/navigation_controller.dart';
import 'package:school_todo/navigation/root_names_container.dart';
import 'package:school_todo/styles/app_colors.dart';
import 'package:school_todo/styles/app_fonts.dart';
import 'package:school_todo/ui/task_list_page/widgets/task_card_widget.dart';
import 'package:school_todo/ui/task_list_page/widgets/task_list_widget.dart';

import 'widgets/title_sliver_app_bar_widget.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        TaskListCubit cubit = TaskListCubit(
            localRepo: Cont.localTaskSavesRepository,
            globalRepo: Cont.globalTaskSavesRepository,
            cubitsConnectorRepo: Cont.cubitsConnectorRepository);
        cubit.loadTaskList();
        return cubit;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppLigthColors.backgroundPrimary,
          body: CustomScrollView(
            slivers: <Widget>[
              SliverPersistentHeader(
                delegate: TitleSliverAppBar(expandedHeight: 132),
                pinned: true,
              ),
              const SliverToBoxAdapter(
                child: TaskList(),
              ),
            ],
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (kDebugMode)
                FloatingActionButton(
                  onPressed: () {
                    // кнопка для вызова краша
                    FirebaseCrashlytics.instance.log("Crash by crashButton");
                    FirebaseCrashlytics.instance.crash();
                  },
                  heroTag: null,
                  child: const Icon(Icons.car_crash),
                ),
              FloatingActionButton(
                onPressed: () {
                  context.read<NavigationController>().navigateTo("editorPage");
                },
                heroTag: null,
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
