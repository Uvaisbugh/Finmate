import 'package:flutter/material.dart';
import 'package:finmate/screens/home/widget/bottom_navigation.dart';
import 'package:finmate/screens/category/screen_category.dart';
import 'package:finmate/screens/transaction/screen_transation.dart';
import 'package:finmate/screens/transaction/add_transaction_screen.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  static const String routeName = '/home';
  final List<Widget> pages = [TransactionScreen(), CategoryScreen()];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF5F7FB), Color(0xFFE3F0FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'Personal Money Manager',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              letterSpacing: 0.5,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white.withOpacity(0.95),
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Center(
              child: ValueListenableBuilder(
                valueListenable: selectedIndexNotifier,
                builder: (context, value, child) {
                  return pages[value];
                },
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddTransactionScreen(),
              ),
            );
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(Icons.add, color: Colors.white),
          tooltip: 'Add Transaction',
        ),
        bottomNavigationBar: const MoneyManagerBottomNavigation(),
      ),
    );
  }
}
