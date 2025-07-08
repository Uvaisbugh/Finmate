import 'package:flutter/material.dart';
import 'package:personal_money_manager/screens/home/screen_home.dart';
import 'package:personal_money_manager/models/category/category_model.dart';
import 'package:personal_money_manager/models/transaction/transaction_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryAdapter().typeId)) {
    Hive.registerAdapter(CategoryAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionAdapter().typeId)) {
    Hive.registerAdapter(TransactionAdapter());
  }
  await Hive.openBox<Category>('categoryBox');
  await Hive.openBox<Transaction>('transactionBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Money Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ScreenHome(),
      debugShowCheckedModeBanner: false,
      routes: {'/home': (context) => ScreenHome()},
    );
  }
}
