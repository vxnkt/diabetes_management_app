import 'package:appathon/authentication/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:appathon/authentication/signin_page.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Use SvgPicture to load the SVG image
            SvgPicture.asset(
              'assets/intro_image.svg',
              height: 300,
            ),
            SizedBox(height: 40),
            Text(
              'DIABETES MANAGEMENT APP',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Optional subtitle
            Text(
              "Managing diabetes is not about deprivation; it's about balance.",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Sign In button
                ElevatedButton(
                  onPressed: () {
                    // Handle Sign In tap and navigate to the sign-in page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple, // Black background color
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text('Sign in', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 20),
                // Register button
                ElevatedButton(
                  onPressed: () {
                    // Handle Register tap and navigate to the register page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple, // Purple background color
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text('SignUp', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
