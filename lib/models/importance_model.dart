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
