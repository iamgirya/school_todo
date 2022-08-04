import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_todo/blocs/task_list/task_list_cubit.dart';
import 'package:school_todo/blocs/task_list/task_list_state.dart';
import 'package:school_todo/styles/app_colors.dart';
import 'package:school_todo/styles/app_fonts.dart';

class TitleSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  TitleSliverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double percentOfShrinkOffset = ((expandedHeight / 2) - shrinkOffset) > 0
        ? ((expandedHeight / 2) - shrinkOffset) / (expandedHeight / 2)
        : 0;
    return Material(
      elevation:
          percentOfShrinkOffset <= 1 / 64 ? 4 - 64 * percentOfShrinkOffset : 0,
      child:
          BlocBuilder<TaskListCubit, TaskListState>(builder: (context, state) {
        if (state is TaskListLoaded) {
          return ColoredBox(
            color: AppLigthColors.backgroundPrimary,
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
                        "Мои дела",
                        style: AppTextStyles.largeTitle.copyWith(
                            fontSize: 20 + 13 * percentOfShrinkOffset),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      if (percentOfShrinkOffset > 0)
                        Opacity(
                          opacity: percentOfShrinkOffset,
                          child: Text(
                            "Выполнено - ${BlocProvider.of<TaskListCubit>(context).getLengthOfCompletedTaskList()}",
                            style: AppTextStyles.title.copyWith(
                                color: AppLigthColors.tertiary,
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
                        // отображение выполненных
                        print(1);
                      },
                      icon: const Icon(
                        Icons.remove_red_eye,
                        color: AppLigthColors.blue,
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
