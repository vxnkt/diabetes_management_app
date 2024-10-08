import 'package:appathon/quiz/quizStart_screen.dart';
import 'package:appathon/screens/doctor_screen.dart';
import 'package:appathon/screens/emergency_screen.dart';
import 'package:appathon/screens/homescreen.dart';
import 'package:appathon/screens/profile_page.dart';
import 'package:appathon/utils/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest_all.dart' as tz;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Track the selected tab

  @override
  void initState() {
    super.initState();
    // Initialize the time zone and notification service
    tz.initializeTimeZones();
    NotificationService.init();

    // Schedule the notification for 2 seconds after the app is opened
    DateTime scheduledTime = DateTime.now().add(Duration(seconds: 2));
    NotificationService.scheduleNotification(
      1,
      "DiaBuddy",
      "Remember to take your medications!",
      scheduledTime,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomesScreen(),
    DoctorScreen(),
    EmergencyScreen(),
    QuizStartScreen(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFEEEFF5),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital_outlined),
            label: 'Doctors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Emergency',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark_outlined),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        elevation: 10,
      ),
    );
  }
}
