import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/onboarding_screen.dart';

void main() {
  runApp(const SunepaApp());
}

class SunepaApp extends StatelessWidget {
  const SunepaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Social Security App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => OnboardingScreen(),
          '/home': (context) => const LoginScreen(),
        });
  }
}
