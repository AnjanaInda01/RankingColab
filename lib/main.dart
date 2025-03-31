// main.dart
import 'package:flutter/material.dart';
import 'package:rankingcolab/pages/logging_page.dart';
import 'package:rankingcolab/pages/signup_page.dart';
import 'package:rankingcolab/pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mind Link',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const WelcomePage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        // Add other routes here
      },
    );
  }
}
