import 'package:flutter/material.dart';

import '../../../models/task_model.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/app_fonts.dart';

class DeadlineChoose extends StatelessWidget {
  const DeadlineChoose({
    Key? key,
  }) : super(key: key);

  final int? selectedDeadLine = 0;
  final bool switchValue = false;

  void _selectDeadLine(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030));
    if (picked != null) {
      int tmpSelectedDeadLine = picked.millisecondsSinceEpoch~/1000;
      if (tmpSelectedDeadLine != selectedDeadLine) {
        setState(() {
          selectedDeadLine = tmpSelectedDeadLine;
        });
      }
    } else if (selectedDeadLine == null) {
      setState(() {
        switchValue = false;
      });
    }
  }

  String? getDayFromUnix(int? unix) { // вывод названия месяца
    if (unix != null) {
      DateTime tmpTime = DateTime.fromMillisecondsSinceEpoch(unix * 1000);

      return "${tmpTime.day} ${tmpTime.month} ${tmpTime.year}";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      width: Size.infinite.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Сделать до",
                style: AppTextStyles.body,
              ),
              GestureDetector(
                onTap: () {
                  if (selectedDeadLine != null && switchValue) {
                    _selectDeadLine(context);
                  }
                },
                child: Text(
                  getDayFromUnix(selectedDeadLine) ?? "Нет" ,
                  style: AppTextStyles.button.copyWith(
                    color: selectedDeadLine != null && switchValue
                        ? AppLigthColors.blue
                        : AppLigthColors.tertiary,
                  ),
                ),
              ),
            ],
          ),
          const Expanded(
            child: SizedBox(),
          ),
          Switch(
            value: switchValue,
            onChanged: (value) {
                switchValue = value;
                if (switchValue && selectedDeadLine == null) {
                  _selectDeadLine(context);
                }
              //изменить состояние
            },
          ),
        ],
      ),
    );
  }
}