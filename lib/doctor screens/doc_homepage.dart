import 'package:flutter/material.dart';
import 'patients_page.dart'; // Import PatientsPage
import 'doctor_profile.dart'; // Import DoctorProfile page

class DocHomepage extends StatefulWidget {
  const DocHomepage({super.key});

  @override
  State<DocHomepage> createState() => _DocHomepageState();
}

class _DocHomepageState extends State<DocHomepage> {
  int _selectedIndex = 0; // Default to Patients tab

  // Method to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // List of pages to display based on the selected index
    List<Widget> pages = [
      const PatientsPage(), // PatientsPage for index 0
      const DoctorProfile(), // Replaced placeholder with DoctorProfile page
    ];

    return Scaffold(
      body: pages[_selectedIndex], // Display the selected page

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Patients',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}
