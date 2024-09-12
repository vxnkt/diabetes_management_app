import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'SignUp.dart'; // Import your SignUpScreen
import 'package:appathon/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appathon',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: SignUpScreen(),  // Set the SignUpScreen as the default
    );
  }
}
