import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:finmate/models/category/category_model.dart';
import 'package:finmate/models/transaction/transaction_model.dart';
import 'package:finmate/screens/home/screen_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(CategoryTypeAdapter());
  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Category>('categoryBox');
  await Hive.openBox<Transaction>('transactionBox');
  await _initializeDefaultCategories();
  runApp(const MyApp());
}

Future<void> _initializeDefaultCategories() async {
  final categoryBox = Hive.box<Category>('categoryBox');
  if (categoryBox.isEmpty) {
    await categoryBox.addAll([
      Category(id: 'salary', name: 'Salary', type: CategoryType.income),
      Category(id: 'freelance', name: 'Freelance', type: CategoryType.income),
      Category(id: 'investment', name: 'Investment', type: CategoryType.income),
      Category(id: 'business', name: 'Business', type: CategoryType.income),
      Category(
        id: 'other_income',
        name: 'Other Income',
        type: CategoryType.income,
      ),
      Category(id: 'food', name: 'Food & Dining', type: CategoryType.expense),
      Category(
        id: 'transport',
        name: 'Transportation',
        type: CategoryType.expense,
      ),
      Category(id: 'shopping', name: 'Shopping', type: CategoryType.expense),
      Category(
        id: 'entertainment',
        name: 'Entertainment',
        type: CategoryType.expense,
      ),
      Category(id: 'health', name: 'Healthcare', type: CategoryType.expense),
      Category(id: 'education', name: 'Education', type: CategoryType.expense),
      Category(
        id: 'bills',
        name: 'Bills & Utilities',
        type: CategoryType.expense,
      ),
      Category(
        id: 'other_expense',
        name: 'Other Expenses',
        type: CategoryType.expense,
      ),
    ]);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Money Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          primary: const Color(0xFF1565C0),
          secondary: const Color(0xFF43A047),
          background: const Color(0xFFF5F7FB),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF1565C0),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Color(0xFF1565C0),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        useMaterial3: true,
      ),
      home: ScreenHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}
