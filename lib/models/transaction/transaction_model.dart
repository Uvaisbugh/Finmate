import 'package:hive/hive.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 2)
class Transaction extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String categoryId;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final DateTime date;

  Transaction({
    required this.id,
    required this.categoryId,
    required this.amount,
    required this.date,
  });
}
