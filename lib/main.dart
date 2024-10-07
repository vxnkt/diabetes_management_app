import 'package:appathon/screens/emergency_screen.dart';
import 'package:appathon/screens/home_page.dart';
import 'package:appathon/quiz/quizStart_screen.dart';
import 'package:appathon/screens/homescreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diabetes Management App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: EmergencyScreen(),
      home: HomePage(),
    );
  }
}

