import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/blocs/app_configuration/app_configuration_cubit.dart';
import 'package:school_todo/blocs/task_list/task_list_cubit.dart';
import 'package:school_todo/repositories/task_list_repository.dart';
import 'package:school_todo/styles/app_colors.dart';
import 'package:school_todo/ui/task_list_page/widgets/task_list_widget.dart';

import '../../core/container_class.dart';
import '../../navigation/delegate.dart';
import '../../repositories/cubits_connector_repository.dart';
import 'widgets/title_sliver_app_bar_widget.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToDoAppColors theme = Theme.of(context).extension<ToDoAppColors>()!;
    double scale = BlocProvider.of<AppConfigurationCubit>(context).appScale;
    return LayoutBuilder(builder: (context, constraints) {
      return BlocProvider(
        create: (context) {
          TaskListCubit cubit = TaskListCubit(
            taskListRepository: Cont.getIt.get<TaskSavesRepository>(),
            cubitsConnectorRepo: Cont.getIt.get<CubitsConnectorRepository>(),
          );
          cubit.initialLoadTaskList();
          return cubit;
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: theme.backgroundPrimary,
            body: CustomScrollView(
              slivers: <Widget>[
                SliverPersistentHeader(
                  delegate:
                      TitleSliverAppBar(expandedHeight: 132, scale: scale),
                  pinned: true,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: const [
                      TaskList(
                        key: Key('taskList'),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 56 * scale,
                  width: 56 * scale,
                  child: FloatingActionButton(
                    onPressed: () {
                      (Router.of(context).routerDelegate as ToDoRouterDelegate)
                          .gotoEditor(null);
                    },
                    heroTag: null,
                    backgroundColor: theme.blue,
                    child: Transform.scale(
                      scale: scale,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
