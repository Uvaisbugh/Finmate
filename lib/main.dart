import 'package:flutter/material.dart';
import 'package:personal_money_manager/screens/home/screen_home.dart';

void main() {
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
