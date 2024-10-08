import 'package:appathon/authentication/signin_page.dart';
import 'package:appathon/authentication/signup.dart';
import 'package:appathon/doctor%20screens/doc_homepage.dart';
import 'package:appathon/screens/emergency_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:appathon/screens/home_page.dart';
import 'package:appathon/quiz/quizStart_screen.dart';
import 'package:appathon/screens/homescreen.dart';
import 'package:appathon/utils/notification_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase initialization
  await NotificationService.init(); // Notification service initialization
  tz.initializeTimeZones(); // Timezone initialization
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
        initialRoute: '/signup', // Initial route for the signup page
        routes: {
          '/signup': (context) => SignupPage(),
          '/home': (context) => HomePage(), // Sign up page route
          '/login': (context) => SignInPage(),
          '/doctorHomePage': (context) => DocHomepage(), // Sign in page route
        });
  }
}
