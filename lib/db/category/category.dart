import 'package:personal_money_manager/models/category/category_model.dart';

abstract class CategoryDBfunctions {
  Future<void> insertCategory(Category category);
  Future<void> updateCategory(Category category);
  Future<void> deleteCategory(String id);
  Future<Category?> getCategory(String id);
  Future<List<Category>> getAllCategories();
}

class CategoryDB implements CategoryDBfunctions {
  @override
  Future<void> insertCategory(Category category) {
    // Implementation for inserting a category into the database
    throw UnimplementedError();
  }

  @override
  Future<void> updateCategory(Category category) {
    // Implementation for updating a category in the database
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCategory(String id) {
    // Implementation for deleting a category from the database
    throw UnimplementedError();
  }

  @override
  Future<Category?> getCategory(String id) {
    // Implementation for retrieving a single category by ID
    throw UnimplementedError();
  }

  @override
  Future<List<Category>> getAllCategories() {
    // Implementation for retrieving all categories from the database
    throw UnimplementedError();
  }
}
