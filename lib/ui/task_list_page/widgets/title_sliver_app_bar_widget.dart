import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/blocs/task_list/task_list_cubit.dart';
import 'package:school_todo/styles/app_colors.dart';
import 'package:school_todo/styles/app_fonts.dart';

import '../../../blocs/app_configuration/app_configuration_cubit.dart';
import '/generated/l10n.dart';

class TitleSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double scale;
  TitleSliverAppBar({required this.expandedHeight, required this.scale});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    ToDoAppColors theme = Theme.of(context).extension<ToDoAppColors>()!;
    AppConfigurationCubit appConfigurationCubit =
        BlocProvider.of<AppConfigurationCubit>(context);
    double scale = appConfigurationCubit.appScale;
    TaskListCubit taskListCubit = BlocProvider.of<TaskListCubit>(context);

    double delta = maxExtent - minExtent;
    double percentOfShrinkOffset =
        (delta - shrinkOffset) / delta > 0 ? (delta - shrinkOffset) / delta : 0;
    return Align(
      child: Material(
        elevation:
            percentOfShrinkOffset <= 0.05 ? 5 - 100 * percentOfShrinkOffset : 0,
        child: BlocBuilder<TaskListCubit, TaskListState>(
            builder: (context, state) {
          return ColoredBox(
            color: theme.backgroundPrimary!,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: 16.0,
                  right: 24,
                  top: 16 + 26 * percentOfShrinkOffset),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 16 + percentOfShrinkOffset * 44,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).taskListTitleName,
                        style: AppTextStyles.largeTitle.copyWith(
                            fontSize: (20 +
                                    13 *
                                        percentOfShrinkOffset *
                                        percentOfShrinkOffset) *
                                scale),
                      ),
                      SizedBox(
                        height: 2 * percentOfShrinkOffset,
                      ),
                      if (state is TaskListLoadedState &&
                          percentOfShrinkOffset > 0.2)
                        Opacity(
                          opacity: percentOfShrinkOffset,
                          child: Text(
                            S.of(context).taskListTitleCompleted(taskListCubit
                                    .getLengthOfTaskList() -
                                taskListCubit.getLengthOfUnCompletedTaskList()),
                            style: AppTextStyles.title.copyWith(
                                color: theme.tertiary,
                                fontSize:
                                    (20 - (1 - percentOfShrinkOffset) * 25 > 0
                                            ? 20 -
                                                (1 - percentOfShrinkOffset) * 25
                                            : 0) *
                                        scale),
                          ),
                        ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 24 * scale,
                    height: 24 * scale,
                    child: Transform.scale(
                      scale: scale,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          taskListCubit.sortTaskList();
                        },
                        icon: Icon(
                          Icons.sort,
                          color: theme.blue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: 24 * scale,
                    height: 24 * scale,
                    child: Transform.scale(
                      scale: scale,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          appConfigurationCubit.changeTheme();
                        },
                        icon: appConfigurationCubit.isLightTheme
                            ? Icon(
                                Icons.nightlight,
                                color: theme.blue,
                              )
                            : Icon(
                                Icons.sunny,
                                color: theme.blue,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: 24 * scale,
                    height: 24 * scale,
                    child: Transform.scale(
                      scale: scale,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          taskListCubit.changeCompletedTaskVisible(
                              const Duration(milliseconds: 500));
                        },
                        icon: state is! TaskListLoadedState ||
                                !taskListCubit.isCompletedVisible
                            ? Icon(
                                Icons.visibility,
                                color: theme.blue,
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: theme.blue,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight * scale;

  @override
  double get minExtent => kToolbarHeight * scale;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
