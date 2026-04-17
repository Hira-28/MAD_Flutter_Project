import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(DishScoreApp());
}

class DishScoreApp extends StatelessWidget {
  const DishScoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dish Score',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: HomePage(),
    );
  }
}
