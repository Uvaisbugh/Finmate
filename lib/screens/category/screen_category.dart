import 'package:flutter/material.dart';
import 'package:personal_money_manager/screens/category/expense_categorylist.dart';
import 'package:personal_money_manager/screens/category/income_categorylist.dart';

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
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(child: Text('Income')),
            Tab(child: Text('Expense')),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // Replace with your IncomeCategorylist widget
              IncomeCategorylist(),
              // Replace with your ExpenseCategorylist widget
              ExpenseCategorylist(),
            ],
          ),
        ),
      ],
    );
  }
}
