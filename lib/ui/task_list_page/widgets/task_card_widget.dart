import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// блок едитора вызывает изменение в локальной базе данных, на неё подписан локальный репозиторий, который пингует 
// блок списка, который вызывает переотрисовку