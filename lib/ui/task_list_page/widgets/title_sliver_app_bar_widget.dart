import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/blocs/task_list/task_list_cubit.dart';
import 'package:school_todo/styles/app_colors.dart';
import 'package:school_todo/styles/app_fonts.dart';

import '/generated/l10n.dart';

class TitleSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  TitleSliverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    ToDoAppColors theme = Theme.of(context).extension<ToDoAppColors>()!;
    double delta = expandedHeight - kToolbarHeight;
    double percentOfShrinkOffset =
        (delta - shrinkOffset) / delta > 0 ? (delta - shrinkOffset) / delta : 0;
    TaskListCubit taskListCubit = BlocProvider.of<TaskListCubit>(context);
    return Align(
      child: Material(
        elevation:
            percentOfShrinkOffset <= 0.05 ? 5 - 100 * percentOfShrinkOffset : 0,
        child:
            BlocBuilder<TaskListCubit, TaskListState>(builder: (context, state) {
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).taskListTitleName,
                          style: AppTextStyles.largeTitle.copyWith(
                              fontSize: 20 + 13 * percentOfShrinkOffset * percentOfShrinkOffset),
                        ),
                        const Spacer(),
                        if (state is TaskListLoadedState && percentOfShrinkOffset > 0.2)
                          Opacity(
                            opacity: percentOfShrinkOffset,
                            child: Text(
                              S.of(context).taskListTitleCompleted(taskListCubit
                                  .getLengthOfTaskList() -
                                  taskListCubit.getUnLengthOfCompletedTaskList()),
                              style: AppTextStyles.title.copyWith(
                                  color: theme.tertiary,
                                  fontSize: 1 + 19 * percentOfShrinkOffset),
                            ),
                          ),
                      ],
                    ),
                    const Spacer(),
                    if (state is TaskListLoadedState)
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            taskListCubit.changeCompletedTaskVisible();
                          },
                          icon: !taskListCubit.isCompletedVisible
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
                  ],
                ),
              ),
            );
        }),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
