import 'package:appathon/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Add this import
import 'package:appathon/auth_methods.dart';
import 'package:appathon/SignUp.dart'; // Import the SignUpScreen

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  bool isLoading = false;

  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: emailController.text, password: passwordController.text);

    setState(() {
      isLoading = false;
    });

    if (res == 'Success') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // SVG Image at the top
              SvgPicture.asset(
                'assets/login.svg', // Replace with your SVG file path
                height: size.height * 0.5, // Adjust the height as needed
              ),
              SizedBox(height: size.height * 0.02),

              // LOGIN text
              Text(
                'LOGIN',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.02),

              // Form fields
              _buildTextField(emailController, "Email", Icons.email),
              _buildTextField(
                passwordController,
                "Password",
                Icons.lock,
                isPassword: true,
                obscureText: obscureText,
                toggleObscureText: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              ),

              SizedBox(height: size.height * 0.02),

              // Centered Login Button
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: loginUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // Deep purple color
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  textStyle: TextStyle(fontSize: 18), // Font size
                ),
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white), // Text color
                ),
              ),

              SizedBox(height: size.height * 0.02),

              // Not Signed Up? Text
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                child: Text(
                  "Not Signed Up?",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String labelText, IconData icon,
      {bool isPassword = false, bool obscureText = false, Function? toggleObscureText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.deepPurple),
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              if (toggleObscureText != null) toggleObscureText();
            },
          )
              : null,
        ),
      ),
    );
  }
}
