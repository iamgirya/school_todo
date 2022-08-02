import 'package:flutter/material.dart';

import '../../../models/task_model.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/app_fonts.dart';

class ClouseButton extends StatelessWidget {
  const ClouseButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 48,
        child: TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: () {
            // удаление
          },
          child: Row(
            children: [
              const SizedBox(
                height: 24,
                width: 24,
                child: Icon(
                  Icons.delete,
                  color: AppLigthColors.red,
                ),
              ),
              const SizedBox(width: 12,),
              Text(
                "Удалить",
                style: AppTextStyles.body.copyWith(
                  color: AppLigthColors.red,
                ),
              )
            ],
          ),
        ));
  }
}

