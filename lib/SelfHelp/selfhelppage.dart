import 'package:appathon/SelfHelp/nonulcer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'ulcer.dart';


class SelfHelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Self Help',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center( // Center the column within the body
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center contents vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Center contents horizontally
            children: [
              // SVG Display Section
              SvgPicture.asset(
                'assets/selfhelp.svg',
                height: 300,
              ),
              SizedBox(height: 30), // Space between the SVG and buttons

              // Ulcer Library Button
              SizedBox(
                width: double.infinity, // Make button take the full width
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to Ulcer page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UlcerPage()),
                    );
                  },
                  child: Text(
                    'Ulcer Library',
                    style: TextStyle(color: Colors.white), // White text color
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    backgroundColor: Colors.deepPurple, // Customize button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0), // Rounded corners
                    ),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(height: 20), // Space between the two buttons

              // Non-Ulcer Library Button
              SizedBox(
                width: double.infinity, // Make button take the full width
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to Non-Ulcer page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NonUlcerPage()),
                    );
                  },
                  child: Text(
                    'Non-Ulcer Library',
                    style: TextStyle(color: Colors.white), // White text color
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    backgroundColor: Colors.deepPurpleAccent, // Customize button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0), // Rounded corners
                    ),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
