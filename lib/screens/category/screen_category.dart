import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:finmate/models/category/category_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Modern Segmented Tab Bar
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F4FA),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: const Color(0xFF1976D2),
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: const Color(0xFF1976D2),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            tabs: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Tab(
                  icon: Icon(Icons.trending_up_rounded, size: 26),
                  text: 'Income',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Tab(
                  icon: Icon(Icons.trending_down_rounded, size: 26),
                  text: 'Expenses',
                ),
              ),
            ],
          ),
        ),
        // Tab Views
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildCategoryList(CategoryType.income),
              _buildCategoryList(CategoryType.expense),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryList(CategoryType type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
          child: Text(
            type == CategoryType.income ? 'Income' : 'Expenses',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 0.5,
              color: Color(0xFF1976D2),
            ),
          ),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: Hive.box<Category>('categoryBox').listenable(),
            builder: (context, Box<Category> box, _) {
              final categories = box.values
                  .where((category) => category.type == type)
                  .toList();

              if (categories.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        type == CategoryType.income
                            ? Icons.trending_up_rounded
                            : Icons.trending_down_rounded,
                        size: 48,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'No ${type == CategoryType.income ? 'income' : 'expense'} categories yet',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isIncome = type == CategoryType.income;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isIncome
                            ? [const Color(0xFF43A047), const Color(0xFF81C784)]
                            : [
                                const Color(0xFFE53935),
                                const Color(0xFFFFB74D),
                              ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.07),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      leading: Container(
                        decoration: BoxDecoration(
                          color: isIncome
                              ? const Color(0xFF388E3C)
                              : const Color(0xFFD32F2F),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  (isIncome
                                          ? const Color(0xFF388E3C)
                                          : const Color(0xFFD32F2F))
                                      .withOpacity(0.13),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Icon(
                          isIncome
                              ? Icons.trending_up_rounded
                              : Icons.trending_down_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      title: Text(
                        category.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        isIncome ? 'Income Category' : 'Expense Category',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 11,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => _editCategory(category),
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 18,
                            ),
                            tooltip: 'Edit',
                          ),
                          IconButton(
                            onPressed: () => _deleteCategory(category),
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 18,
                            ),
                            tooltip: 'Delete',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _editCategory(Category category) {
    final nameController = TextEditingController(text: category.name);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Category'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Category Name',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.trim().isNotEmpty) {
                final updatedCategory = Category(
                  id: category.id,
                  name: nameController.text.trim(),
                  type: category.type,
                );
                category.delete();
                Hive.box<Category>('categoryBox').add(updatedCategory);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteCategory(Category category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Category'),
        content: Text('Are you sure you want to delete "${category.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              category.delete();
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
