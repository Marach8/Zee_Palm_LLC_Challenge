import 'package:flutter/material.dart';
import 'package:task1_todo_list_app/views/landing_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
        useMaterial3: true,
        brightness: Brightness.light
      ),
      home: const LandingView()
    );
  }
}