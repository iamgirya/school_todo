import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:school_todo/navigation/navigation_controller.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       child: TextButton(
        onPressed: () {
          context.read<NavigationController>().navigateTo("editorPage");
        },
        child: Text("fsd"),
       ),
    );
  }
}