import 'package:flutter/material.dart';
import 'package:personal_money_manager/screens/home/widget/bottom_navigation.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final List<Widget> pages = [ScreenTransactions(), ScreenCategory()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Center(
          child: Text(
            'Welcome to Personal Money Manager',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
    );
  }
}
