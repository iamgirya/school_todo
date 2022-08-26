import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_todo/blocs/task_list/task_list_cubit.dart';
import 'package:school_todo/models/task_model.dart';
import 'package:school_todo/styles/app_colors.dart';
import 'package:school_todo/styles/app_fonts.dart';

import '../../../blocs/app_configuration/app_configuration_cubit.dart';
import '../../../models/importance_model.dart';
import '../../../navigation/delegate.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(
      {Key? key, required this.task, required this.animationController})
      : super(key: key);

  final Task task;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    ToDoAppColors theme = Theme.of(context).extension<ToDoAppColors>()!;
    TaskListCubit taskListCubit = BlocProvider.of<TaskListCubit>(context);
    double scale = BlocProvider.of<AppConfigurationCubit>(context).appScale;

    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInCirc,
      ),
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOutQuart,
        ),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: const Offset(0, 0),
          ).animate(CurvedAnimation(
              parent: animationController, curve: Curves.linear)),
          child: ListTile(
            contentPadding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 18 * scale,
                  width: 18 * scale,
                  child: Transform.scale(
                    alignment: Alignment.topCenter,
                    scale: 1,
                    child: ColoredBox(
                      color:
                          !task.done && task.importance == Importance.important
                              ? theme.importTaskColor!.withOpacity(0.16)
                              : theme.importTaskColor!.withOpacity(0.0),
                      child: Checkbox(
                        value: task.done,
                        activeColor: theme.green,
                        fillColor: !task.done &&
                                task.importance == Importance.important
                            ? MaterialStateProperty.all(theme.importTaskColor)
                            : null,
                        onChanged: (_) {
                          taskListCubit.changeTaskComplete(
                              chosenTask: task,
                              animationDuration:
                                  !taskListCubit.isCompletedVisible
                                      ? const Duration(milliseconds: 500)
                                      : null);
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12 * scale,
                ),
                if (task.importance != Importance.basic)
                  SizedBox(
                    height: 24 * scale,
                    width: 16 * scale,
                    child: task.importance == Importance.important
                        ? SvgPicture.asset('assets/images/double_ex.svg')
                        : const Icon(Icons.arrow_downward),
                  ),
                if (task.importance != Importance.basic)
                  SizedBox(
                    width: 8 * scale,
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.text,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: task.done
                            ? AppTextStyles.body.copyWith(
                                color: theme.tertiary,
                                decoration: TextDecoration.lineThrough,
                                fontSize: AppTextStyles.body.fontSize! * scale,
                              )
                            : AppTextStyles.body.copyWith(
                                fontSize: AppTextStyles.body.fontSize! * scale,
                              ),
                      ),
                      SizedBox(
                        height: 4 * scale,
                      ),
                      if (task.deadline != null)
                        Text(
                          task.getConvertUnixToStringDate()!,
                          style: AppTextStyles.subhead.copyWith(
                            color: theme.tertiary,
                            fontSize: AppTextStyles.body.fontSize! * scale,
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 12 * scale,
                ),
                SizedBox(
                  height: 24 * scale,
                  width: 24 * scale,
                  child: Transform.scale(
                    scale: scale,
                    alignment: Alignment.center,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        (Router.of(context).routerDelegate
                                as ToDoRouterDelegate)
                            .gotoEditor(task.id);
                      },
                      icon: const Icon(Icons.info_outline),
                      color: theme.gray,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
