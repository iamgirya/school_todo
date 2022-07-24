import 'package:flutter/material.dart';
import 'package:school_todo/styles/app_colors.dart';
import 'package:school_todo/styles/app_fonts.dart';

import '../model/task_model.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({Key? key, this.task}) : super(key: key);

  final Task? task;

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {

  TextEditingController taskController = TextEditingController();
  Importance? importance;
  int? selectedDeadLine;
  bool switchValue = false;

  void _selectDeadLine(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030));
    if (picked != null) { // разобраться с часовыми поясами
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
    return Scaffold(
      backgroundColor: AppLigthColors.backgroundPrimary,
      appBar: AppBar(
        scrolledUnderElevation: 4,
        elevation: 0,
        backgroundColor: AppLigthColors.backgroundPrimary,
        leading: SizedBox(
          height: 14,
          width: 14,
          child: IconButton(
              onPressed: () {
                // выход
              },
              icon: Icon(
                Icons.close,
                color: AppLigthColors.primary,
              )),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // сохранение
            },
            child: Text(
              "СОХРАНИТЬ",
              style: AppTextStyles.button.copyWith(
                color: AppLigthColors.blue,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: const BoxConstraints(minHeight: 104),
                child: Card(
                  color: AppLigthColors.backgroundSecondary,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      style: AppTextStyles.body,
                      textAlignVertical: TextAlignVertical.top,
                      maxLines: null,
                      minLines: 2,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: "Что надо сделать...",
                        hintStyle: AppTextStyles.body.copyWith(color: AppLigthColors.tertiary),
                        border: InputBorder.none,
                      ),
                      controller: taskController,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                height: 72,
                width: Size.infinite.width,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Важность",
                        style: AppTextStyles.body,
                      ),
                      DropdownButton(
                        // понять, как растянуть на всю линию и при этом оставить нормальное всплывающее меню
                        // понять, как сделать отступ от края
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
                          setState(() {
                            importance = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 0.5,
                color: AppLigthColors.separator,
              ),
              SizedBox(
                height: 72,
                width: Size.infinite.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
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
                        setState(() {
                          switchValue = value;
                          if (switchValue && selectedDeadLine == null) {
                            _selectDeadLine(context);
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Divider(
                height: 0.5,
                color: AppLigthColors.separator,
              ),
              SizedBox(
                  height: 48,
                  child: TextButton(
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: () {
                      // удаление
                    },
                    child: Row(
                      children: [
                        SizedBox(
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
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
