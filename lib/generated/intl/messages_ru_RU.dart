// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru_RU locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru_RU';

  static String m0(completedCount) => "Выполнено - ${completedCount}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "dialogAcceptedDeleting": MessageLookupByLibrary.simpleMessage(
            "Вы уверены, что хотите удалить задачу?"),
        "editorDeadlineTitle":
            MessageLookupByLibrary.simpleMessage("Сделать до"),
        "editorDeleteButton": MessageLookupByLibrary.simpleMessage("Удалить"),
        "editorImportanceBasic": MessageLookupByLibrary.simpleMessage("Нет"),
        "editorImportanceImportant":
            MessageLookupByLibrary.simpleMessage("!!Высокий"),
        "editorImportanceLow": MessageLookupByLibrary.simpleMessage("Низкий"),
        "editorImportanceTitle":
            MessageLookupByLibrary.simpleMessage("Важность"),
        "editorSaveButton": MessageLookupByLibrary.simpleMessage("СОХРАНИТЬ"),
        "editorTextTaskHint":
            MessageLookupByLibrary.simpleMessage("Что-то надо сделать..."),
        "noWord": MessageLookupByLibrary.simpleMessage("Нет"),
        "taskListFastTaskHint": MessageLookupByLibrary.simpleMessage("Новое"),
        "taskListTitleCompleted": m0,
        "taskListTitleName": MessageLookupByLibrary.simpleMessage("Мои дела"),
        "yesWord": MessageLookupByLibrary.simpleMessage("Да")
      };
}
