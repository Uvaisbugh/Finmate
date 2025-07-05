import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  late TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Tab(child: Text('Income')),
        Tab(child: Text('Expense')),
      ],
    );
  }
}
