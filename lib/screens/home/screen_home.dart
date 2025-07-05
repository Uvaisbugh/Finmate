import 'package:flutter/material.dart';
import 'package:personal_money_manager/screens/home/widget/bottom_navigation.dart';
import 'package:personal_money_manager/screens/category/screen_category.dart';
import 'package:personal_money_manager/screens/transaction/screen_transation.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  static const String routeName = '/home';
  final List<Widget> pages = [TransactionScreen(), CategoryScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Personal Money Manager'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ValueListenableBuilder(
            valueListenable: selectedIndexNotifier,
            builder: (context, value, child) {
              return pages[value];
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
          } else {}
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
    );
  }
}
