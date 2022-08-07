import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:school_todo/blocs/task_list/task_list_cubit.dart';
import 'package:school_todo/blocs/task_list/task_list_state.dart';
import 'package:school_todo/core/logger.dart';
import 'package:school_todo/styles/app_colors.dart';
import 'package:school_todo/styles/app_fonts.dart';

import '/generated/l10n.dart';

class TitleSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  TitleSliverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double delta = expandedHeight - kToolbarHeight;
    double percentOfShrinkOffset =
        (delta - shrinkOffset) / delta > 0 ? (delta - shrinkOffset) / delta : 0;
    TaskListCubit taskListCubit = BlocProvider.of<TaskListCubit>(context);
    return Material(
      elevation:
          percentOfShrinkOffset <= 0.05 ? 5 - 100 * percentOfShrinkOffset : 0,
      child:
          BlocBuilder<TaskListCubit, TaskListState>(builder: (context, state) {
        if (state is TaskListReady) {
          return ColoredBox(
            color: AppLightColors.backgroundPrimary,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).taskListTitleName,
                        style: AppTextStyles.largeTitle.copyWith(
                            fontSize: 20 + 13 * percentOfShrinkOffset),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      if (percentOfShrinkOffset > 0.2)
                        Opacity(
                          opacity: percentOfShrinkOffset,
                          child: Text(
                            S.of(context).taskListTitleCompleted(taskListCubit
                                    .getLengthOfTaskList() -
                                taskListCubit.getUnLengthOfCompletedTaskList()),
                            style: AppTextStyles.title.copyWith(
                                color: AppLightColors.tertiary,
                                fontSize: 1 + 19 * percentOfShrinkOffset),
                          ),
                        ),
                    ],
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        taskListCubit.changeCompletedTaskVisible();
                        logger.info(
                            "Change completed task visible to ${taskListCubit.isCompletedVisible}");
                      },
                      icon: !taskListCubit.isCompletedVisible
                          ? const Icon(
                              Icons.visibility,
                              color: AppLightColors.blue,
                            )
                          : const Icon(
                              Icons.visibility_off,
                              color: AppLightColors.blue,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
