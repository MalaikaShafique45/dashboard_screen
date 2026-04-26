import 'package:flutter/material.dart';
import 'dart:async';
import 'welcome_screen.dart';
import '../../utility/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 6), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.primaryGreen,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Animation
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 2.0),
                duration: const Duration(seconds: 3),
                curve: Curves.easeOutBack,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value.clamp(0.0, 1.0),
                    child: Opacity(
                      opacity: value.clamp(0.0, 1.0),
                      child: child,
                    ),
                  );
                },
                child: Image.asset(
                  'assets/images/logo.png.png', // Ek baar .png check kar lein
                  width: 290,
                  height: 290,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 30),
              // Text
              const Text(
                "Welcome to our\nFarm with AI",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 40),
              const SizedBox(
                width: 45,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}