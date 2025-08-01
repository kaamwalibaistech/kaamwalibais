import 'package:flutter/material.dart';
import 'package:kaamwaalibais/Navigation_folder/navigation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kaamwalibais',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: Color(0xff7400b9),
          seedColor: Color(0xff7400b9),
        ),
      ),
      home: const NavigationScreen(),
    );
  }
}
