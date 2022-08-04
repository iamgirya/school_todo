import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_todo/models/task_model.dart';
import 'package:school_todo/navigation/navigation_controller.dart';
import 'package:school_todo/navigation/root_names_container.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      title: Row(children: [
        Text(task.text),
        Text(task.deadline.toString()),
        Text(task.importance.toString()),
        IconButton(onPressed: (){
          context
                      .read<NavigationController>()
                      .navigateTo(RouteNames.editorPage, arguments: task);
        }, icon: Icon(Icons.earbuds))
      ]),
    );
  }
}

// блок едитора вызывает изменение в локальной базе данных, на неё подписан локальный репозиторий, который пингует 
// блок списка, который вызывает переотрисовку