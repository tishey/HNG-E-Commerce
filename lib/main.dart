import 'package:flutter/material.dart';
import 'package:hng_task_two_ecommerce/src/bottom-nav/app_bottom_nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HNG Stage Two Task',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 39, 24, 65)),
        useMaterial3: true,
      ),
      home: const AppBottomNav(),
    );
  }
}
