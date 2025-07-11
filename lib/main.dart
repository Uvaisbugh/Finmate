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
      title: 'Finmate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          primary: const Color(0xFF1565C0),
          secondary: const Color(0xFF43A047),
          surface: const Color(0xFFF5F7FB),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
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
      darkTheme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFF1DB954),
          onPrimary: Colors.black,
          secondary: Color(0xFF222831),
          onSecondary: Colors.white,
          surface: Color(0xFF181A20),
          onSurface: Colors.white,
          error: Colors.red.shade400,
          onError: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.black,
        cardColor: Color(0xFF181A20),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white70),
          titleLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white70),
          labelLarge: TextStyle(color: Colors.white),
          labelMedium: TextStyle(color: Colors.white),
          labelSmall: TextStyle(color: Colors.white70),
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: ScreenHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}
