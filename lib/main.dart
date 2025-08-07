import 'package:flutter/material.dart';
import 'package:kaamwaalibais/Navigation_folder/navigation_screen.dart';
import 'package:kaamwaalibais/utils/font.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kaamwalibais',
      theme: ThemeData(
        textTheme: textTheme,
        colorScheme: ColorScheme.fromSeed(
          primary: Color(0xff7400b9),
          seedColor: Color(0xff7400b9),
        ),
      ),
      home: const NavigationScreen(),
    );
  }
}
