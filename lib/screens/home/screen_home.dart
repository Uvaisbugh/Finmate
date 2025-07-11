import 'package:flutter/material.dart';
import 'package:finmate/screens/home/widget/bottom_navigation.dart';
import 'package:finmate/screens/category/screen_category.dart';
import 'package:finmate/screens/transaction/screen_transation.dart';
import 'package:finmate/screens/transaction/add_transaction_screen.dart';
import 'package:finmate/screens/analytics/analytics_screen.dart';

class ScreenHome extends StatelessWidget {
  final VoidCallback? toggleTheme;
  const ScreenHome({super.key, this.toggleTheme});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = const [TransactionScreen(), AnalyticsScreen()];
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
            'FinMate',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              letterSpacing: 0.5,
            ),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).iconTheme.color,
              ),
              tooltip: 'Settings / Manage Categories',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoryScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: ValueListenableBuilder(
            valueListenable: selectedIndexNotifier,
            builder: (context, value, child) {
              if (value < 0 || value >= pages.length) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.error, color: Colors.red, size: 48),
                      SizedBox(height: 16),
                      Text(
                        'Page not found',
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Please restart the app or contact support.',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }
              return pages[value];
            },
          ),
        ),
        floatingActionButton: ValueListenableBuilder<int>(
          valueListenable: selectedIndexNotifier,
          builder: (context, value, child) {
            if (value == 0) {
              // Transactions tab: show add transaction FAB
              return FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddTransactionScreen(),
                    ),
                  );
                },
                backgroundColor: Theme.of(context).colorScheme.primary,
                tooltip: 'Add Transaction',
                child: const Icon(Icons.add, color: Colors.white),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        bottomNavigationBar: const MoneyManagerBottomNavigation(),
      ),
    );
  }
}
