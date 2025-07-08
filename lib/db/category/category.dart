import 'package:hive/hive.dart';
import 'package:personal_money_manager/models/category/category_model.dart';

// ignore: constant_identifier_names
const String CATEGORY_BOX_NAME = 'categoryBox';

abstract class CategoryDBfunctions {
  Future<void> insertCategory(Category category);
  Future<void> updateCategory(Category category);
  Future<void> deleteCategory(String id);
  Future<Category?> getCategory(String id);
  Future<List<Category>> getAllCategories();
}

class CategoryDB implements CategoryDBfunctions {
  @override
  Future<void> insertCategory(Category category) async {
    final box = await Hive.openBox<Category>(CATEGORY_BOX_NAME);
    box.put(category.id, category);
  }

  @override
  Future<void> updateCategory(Category category) async {
    final box = await Hive.openBox<Category>(CATEGORY_BOX_NAME);
    box.put(category.id, category);
  }

  @override
  Future<void> deleteCategory(String id) async {
    final box = await Hive.openBox<Category>(CATEGORY_BOX_NAME);
    box.delete(id);
  }

  @override
  Future<Category?> getCategory(String id) async {
    final box = await Hive.openBox<Category>(CATEGORY_BOX_NAME);
    return box.get(id);
  }

  @override
  Future<List<Category>> getAllCategories() async {
    final box = await Hive.openBox<Category>(CATEGORY_BOX_NAME);
    return box.values.toList();
  }
}
