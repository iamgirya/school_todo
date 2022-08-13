import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:school_todo/blocs/task_list/task_list_cubit.dart';
import 'package:school_todo/navigation/navigation_controller.dart';
import 'package:school_todo/repositories/global_task_repository.dart';
import 'package:school_todo/repositories/local_task_repository.dart';
import 'package:school_todo/styles/app_colors.dart';
import 'package:school_todo/ui/task_list_page/widgets/task_list_widget.dart';

import '../../repositories/cubits_connector_repository.dart';
import 'widgets/title_sliver_app_bar_widget.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({Key? key, required this.toggleTheme,}) : super(key: key);

  final void Function() toggleTheme;

  @override
  Widget build(BuildContext context) {
    ToDoAppColors theme = Theme.of(context).extension<ToDoAppColors>()!;
    return BlocProvider(
      create: (context) {
        GetIt getIt = GetIt.instance;
        TaskListCubit cubit = TaskListCubit(
            localRepo: getIt.get<ILocalTaskSavesRepository>(),
            globalRepo: getIt.get<IGlobalTaskSavesRepository>(),
            cubitsConnectorRepo: getIt.get<ICubitsConnectorRepository>(),
        );
        cubit.loadTaskList();
        return cubit;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: theme.backgroundPrimary,
          body: CustomScrollView(
            slivers: <Widget>[
              SliverPersistentHeader(
                delegate: TitleSliverAppBar(expandedHeight: 132),
                pinned: true,
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: const [
                    TaskList(),
                    SizedBox(height: 8,),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (kDebugMode)
                FloatingActionButton(
                  onPressed: () {
                    // кнопка для вызова ошибки
                    //FirebaseCrashlytics.instance.crash();
                    toggleTheme();
                  },
                  heroTag: null,
                  child: const Icon(Icons.error),
                ),

              FloatingActionButton(
                onPressed: () {
                  context.read<NavigationController>().navigateTo("editorPage");
                },
                heroTag: null,
                backgroundColor: theme.blue,
                child: const Icon(Icons.add, color: Colors.white ,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
