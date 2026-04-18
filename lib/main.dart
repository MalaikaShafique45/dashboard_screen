import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Ye line sabse zaroori hai!

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kisan Sahulat',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      // main.dart file kholein aur home property ko aise change karein:
      home: const SplashScreen(),
    );
  }
}