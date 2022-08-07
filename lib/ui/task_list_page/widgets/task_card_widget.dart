import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:school_todo/core/container_class.dart';
import 'package:school_todo/models/task_model.dart';
import 'package:school_todo/navigation/navigation_controller.dart';
import 'package:school_todo/navigation/root_names_container.dart';
import 'package:school_todo/styles/app_colors.dart';
import 'package:school_todo/styles/app_fonts.dart';

import '../../../models/importance_model.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: task.done
                ? const Icon(
                    Icons.check_box,
                    color: AppLightColors.green,
                  )
                : task.importance == Importance.important
                    ? Icon(
                        Icons.check_box_outline_blank,
                        color: AppLightColors.importTaskColor,
                      )
                    : const Icon(Icons.check_box_outline_blank),
          ),
          const SizedBox(
            width: 12,
          ),
          if (task.importance != Importance.basic)
            SizedBox(
              height: 24,
              width: 16,
              child: task.importance == Importance.important
                  ? SvgPicture.asset('assets/images/double_ex.svg')
                  : const Icon(Icons.arrow_downward),
            ),
          if (task.importance != Importance.basic)
            const SizedBox(
              width: 8,
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.text,
                style: task.done
                    ? AppTextStyles.body.copyWith(
                        color: AppLightColors.tertiary,
                        decoration: TextDecoration.lineThrough,
                      )
                    : AppTextStyles.body,
              ),
              const SizedBox(
                height: 4,
              ),
              if (task.deadline != null)
                Text(
                  Cont.convertUnixToStringDate(task.deadline)!,
                  style: AppTextStyles.subhead
                      .copyWith(color: AppLightColors.tertiary),
                ),
            ],
          ),
          const Expanded(
            child: SizedBox(),
          ),
          SizedBox(
            height: 24,
            width: 24,
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                context
                    .read<NavigationController>()
                    .navigateTo(RouteNames.editorPage, arguments: task);
              },
              icon: const Icon(Icons.info_outline),
              color: AppLightColors.gray,
            ),
          ),
        ],
      ),
    );
  }
}
