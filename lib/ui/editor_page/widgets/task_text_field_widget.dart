import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../styles/app_colors.dart';
import '../../../styles/app_fonts.dart';

class TaskTextField extends StatelessWidget {
  const TaskTextField({
    Key? key,
  }) : super(key: key);

  
  final TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}