import 'package:flutter/material.dart';
import 'package:get_x_practi/home_view.dart';
import 'package:get_x_practi/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
