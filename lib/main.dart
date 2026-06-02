import 'package:flutter/material.dart';
import 'package:task_buddy/screens/homeScreen.dart';
import 'package:task_buddy/utils/app_themes.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: AppThemes.light,
      home: const HomeScreen(),
    );
  }
}
