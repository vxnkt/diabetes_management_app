
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Add this import
import 'package:appathon/auth_methods.dart';
import '../login.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  int selectedAge = 18;
  String selectedGender = 'Male';
  String selectedDiabetesType = 'Type 1';
  String selectedDiabetesDuration = 'Less than 6 Months';

  bool isLoading = false;

  final List<int> ages = List<int>.generate(73, (i) => i + 18);
  final List<String> diabetesTypes = ['Type 1', 'Type 2', 'Gestational Diabetes'];
  final List<String> diabetesDurations = [
    'Less than 6 Months', '1 year', '2 years', '3 years', '4 years', '5 years', '6 years',
    '7 years', '8 years', '9 years', '10 years', '11 years', '12 and more than 12 years'
  ];

  void signUp() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        mobileController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all the fields')),
      );
      return;
    }
    setState(() {
      isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
      name: nameController.text,
      age: selectedAge,
      gender: selectedGender,
      mobile: mobileController.text,
      diabetesType: selectedDiabetesType,
      diabetesDuration: selectedDiabetesDuration,
      email: emailController.text,
      password: passwordController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (res == 'Success') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res)),
      );
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SVG Image at the top
              Center(
                child: SvgPicture.asset(
                  'assets/signup.svg', // Replace with your SVG file path
                  height: size.height * 0.5, // Adjust the height as needed
                ),
              ),
              SizedBox(height: size.height * 0.02),

              // Title at the top
              Text(
                'SIGNUP',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.02),

              // Form fields
              _buildTextField(nameController, "Name", Icons.person),
              _buildTextField(mobileController, "Mobile Number", Icons.phone),
              _buildTextField(emailController, "Email", Icons.email),
              _buildTextField(passwordController, "Password", Icons.lock, obscureText: true),

              // Age dropdown
              _buildDropdownField(
                title: 'Age',
                value: selectedAge,
                items: ages.map((age) {
                  return DropdownMenuItem<int>(
                    value: age,
                    child: Text(age.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedAge = value!;
                  });
                },
              ),

              // Gender dropdown
              _buildDropdownField(
                title: 'Gender',
                value: selectedGender,
                items: ['Male', 'Female', 'Other'].map((gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGender = value!;
                  });
                },
              ),

              // Type of Diabetes dropdown
              _buildDropdownField(
                title: 'Type of Diabetes',
                value: selectedDiabetesType,
                items: diabetesTypes.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDiabetesType = value!;
                  });
                },
              ),

              // Duration of Diabetes dropdown
              _buildDropdownField(
                title: 'Duration of Diabetes',
                value: selectedDiabetesDuration,
                items: diabetesDurations.map((duration) {
                  return DropdownMenuItem<String>(
                    value: duration,
                    child: Text(duration),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDiabetesDuration = value!;
                  });
                },
              ),

              SizedBox(height: size.height * 0.02),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Center(
                child: ElevatedButton(
                  onPressed: signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple, // Deep purple color
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32), // Larger padding
                    textStyle: TextStyle(fontSize: 18), // Larger text
                  ),
                  child: Text("Sign Up", style: TextStyle(color: Colors.white)),
                ),
              ),

              SizedBox(height: size.height * 0.02),

              // Redirect text
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text(
                    'Already signed in?',
                    style: TextStyle(color: Colors.deepPurple, fontSize: 16),
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
      TextEditingController controller, String labelText, IconData icon, {bool obscureText = false}) {
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
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String title,
    required dynamic value,
    required List<DropdownMenuItem<dynamic>> items,
    required void Function(dynamic) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          DropdownButtonFormField<dynamic>(
            value: value,
            items: items,
            onChanged: onChanged,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
