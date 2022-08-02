import 'package:flutter/material.dart';

import '../../../models/task_model.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/app_fonts.dart';

class ImportanceChoose extends StatelessWidget {
  const ImportanceChoose({
    Key? key,
  }) : super(key: key);

  final Importance importance = Importance.basic;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      width: Size.infinite.width,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Важность",
              style: AppTextStyles.body,
            ),
            ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton(
                // понять, как растянуть на всю линию и при этом оставить нормальное всплывающее меню
                style: AppTextStyles.subhead
                    .copyWith(color: AppLigthColors.tertiary),
                value: importance,
                icon: const SizedBox(),
                underline: const SizedBox(),
                isDense: true,
                hint: Text(
                  "Нет",
                  style: AppTextStyles.subhead
                      .copyWith(color: AppLigthColors.tertiary),
                ),
                items: [
                  DropdownMenuItem<Importance>(
                    value: Importance.basic,
                    child: Text(
                      "Нет",
                      style: AppTextStyles.subhead
                          .copyWith(color: AppLigthColors.primary),
                    ),
                  ),
                  DropdownMenuItem<Importance>(
                    value: Importance.low,
                    child: Text(
                      "Низкий",
                      style: AppTextStyles.subhead
                          .copyWith(color: AppLigthColors.primary),
                    ),
                  ),
                  DropdownMenuItem<Importance>(
                    value: Importance.important,
                    child: Text(
                      "!! Высокий",
                      style: AppTextStyles.subhead
                          .copyWith(color: AppLigthColors.red),
                    ),
                  ),
                ],
                onChanged: (Importance? value) {
                  // importance = value;
                  //изменить состояние
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
