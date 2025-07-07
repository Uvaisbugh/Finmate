import 'package:hive/hive.dart'; // Use hive, not hive_flutter, for model files
part 'category_model.g.dart';

@HiveType(typeId: 0)
enum CategoryType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}

@HiveType(typeId: 1)
class Category extends HiveObject {
  // Extend HiveObject for easy box operations
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isDeleted;
  @HiveField(3)
  final CategoryType type;

  Category({
    required this.id,
    required this.name,
    this.isDeleted = false,
    required this.type,
  });
}

// Run this command to generate the adapter:
// dart run build_runner build --delete-conflicting-outputs
