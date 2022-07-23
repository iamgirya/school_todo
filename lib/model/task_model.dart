import 'dart:ffi';

class Task {
  const Task({
    required this.text,
    required this.importance,
    required this.deadline,
    required this.done,
  });
  final String text;
  final Importance importance;
  final int deadline;
  final bool done;
}

enum Importance {
  low ,
  basic ,
  important,
}