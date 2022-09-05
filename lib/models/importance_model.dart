import 'package:hive/hive.dart';
part 'importance_model.g.dart';

@HiveType(typeId: 1)
enum Importance {
  @HiveField(0)
  basic,
  @HiveField(1)
  low,
  @HiveField(2)
  important,
}

extension StringToEnum on String {
  Importance toImportance() {
    return Importance.values.firstWhere(
      (element) => element.name == this,
      orElse: () => throw Exception('Unknown importance $this'),
    );
  }
}

int importanceToInt(Importance importance) {
  if (importance == Importance.important) {
    return 10;
  } else if (importance == Importance.basic) {
    return 0;
  } else if (importance == Importance.low) {
    return -10;
  }
  return 0;
}
