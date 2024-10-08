import 'package:appathon/quiz/quizStart_screen.dart';
import 'package:appathon/screens/emergency_screen.dart';
import 'package:appathon/screens/homescreen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Track the selected tab

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomesScreen(),
    Text('Doctor Page', style: TextStyle(fontSize: 24)),
    EmergencyScreen(),
    QuizStartScreen(),
    Text('Profile Page', style: TextStyle(fontSize: 24)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
      ),
    );
  }

//   Widget _buildActionButton(
//       {required IconData icon,
//       required String label,
//       required Function onTap}) {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: () => onTap(),
//           child: Container(
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: LinearGradient(
//                 colors: [Colors.blueAccent, Colors.lightBlueAccent],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: Icon(
//               icon,
//               size: 30,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         SizedBox(height: 10),
//         Text(label),
//       ],
//     );
//   }
}
