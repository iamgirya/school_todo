// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en_US locale. All the
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
  String get localeName => 'en_US';

  static String m0(completedCount) => "Completed - ${completedCount}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "dialogAcceptedDeleting": MessageLookupByLibrary.simpleMessage(
            "Are you sure, that you want to delete task?"),
        "editorDeadlineTitle":
            MessageLookupByLibrary.simpleMessage("Do before"),
        "editorDeleteButton": MessageLookupByLibrary.simpleMessage("Delete"),
        "editorImportanceBasic": MessageLookupByLibrary.simpleMessage("No"),
        "editorImportanceImportant":
            MessageLookupByLibrary.simpleMessage("!!High"),
        "editorImportanceLow": MessageLookupByLibrary.simpleMessage("Low"),
        "editorImportanceTitle":
            MessageLookupByLibrary.simpleMessage("Importance"),
        "editorSaveButton": MessageLookupByLibrary.simpleMessage("SAVE"),
        "editorTextTaskHint":
            MessageLookupByLibrary.simpleMessage("Something to do..."),
        "noWord": MessageLookupByLibrary.simpleMessage("No"),
        "taskListFastTaskHint": MessageLookupByLibrary.simpleMessage("New"),
        "taskListTitleCompleted": m0,
        "taskListTitleName":
            MessageLookupByLibrary.simpleMessage("My business"),
        "yesWord": MessageLookupByLibrary.simpleMessage("Yes")
      };
}
