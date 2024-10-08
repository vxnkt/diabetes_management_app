import 'package:appathon/authentication/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../firebase/auth_methods.dart';


class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = '';
  int _age = 18;
  String _gender = 'Male';
  String _mobileNumber = '';
  String _email = '';
  String _password = '';
  String _diabetesType = 'Type 1';
  String _diabetesDuration = 'Less than 6 Months';
  bool _isLoading = false;

  AuthMethods _authMethods = AuthMethods();

  InputDecoration _inputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: Colors.deepPurple),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      setState(() {
        _isLoading = true;
      });

      String? result = await _authMethods.signupUser(
        email: _email,
        password: _password,
        mobileNumber: _mobileNumber,
        name: _name,
        age: _age,
        gender: _gender,
        diabetesType: _diabetesType,
        diabetesDuration: _diabetesDuration,
      );

      setState(() {
        _isLoading = false;
      });

      if (result == "Success") {
        // Navigate to MedicalDetailsPage after successful signup
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MedicalDetailsPage()),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(result ?? "An error occurred. Please try again."),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/signin.svg',
                height: 300,
              ),
              SizedBox(height: 40),

              // Name Field
              TextFormField(
                decoration: _inputDecoration('Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value ?? '',
              ),
              SizedBox(height: 16),

              // Age Field
              DropdownButtonFormField<int>(
                decoration: _inputDecoration('Age'),
                value: _age,
                items: List.generate(73, (index) => 18 + index)
                    .map((age) => DropdownMenuItem(
                  value: age,
                  child: Text(age.toString()),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _age = value!),
              ),
              SizedBox(height: 16),

              // Gender Field
              DropdownButtonFormField<String>(
                decoration: _inputDecoration('Gender'),
                value: _gender,
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _gender = value!),
              ),
              SizedBox(height: 16),

              // Mobile Number Field
              TextFormField(
                decoration: _inputDecoration('Mobile Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile number';
                  }
                  return null;
                },
                onSaved: (value) => _mobileNumber = value ?? '',
              ),
              SizedBox(height: 16),

              // Email Field
              TextFormField(
                decoration: _inputDecoration('Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onSaved: (value) => _email = value ?? '',
              ),
              SizedBox(height: 16),

              // Password Field
              TextFormField(
                decoration: _inputDecoration('Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                onSaved: (value) => _password = value ?? '',
              ),
              SizedBox(height: 16),

              // Type of Diabetes Field
              DropdownButtonFormField<String>(
                decoration: _inputDecoration('Type of Diabetes'),
                value: _diabetesType,
                items: ['Type 1', 'Type 2', 'Gestational Diabetes']
                    .map((type) => DropdownMenuItem(
                  value: type,
                  child: Text(type),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _diabetesType = value!),
              ),
              SizedBox(height: 16),

              // Duration of Diabetes Field
              DropdownButtonFormField<String>(
                decoration: _inputDecoration('Duration of Diabetes'),
                value: _diabetesDuration,
                items: [
                  'Less than 6 Months',
                  '12 months (1 year)',
                  for (int i = 2; i <= 12; i++) '$i years',
                  'More than 12 years'
                ].map((duration) => DropdownMenuItem(
                  value: duration,
                  child: Text(duration),
                )).toList(),
                onChanged: (value) =>
                    setState(() => _diabetesDuration = value!),
              ),
              SizedBox(height: 40),

              // Sign Up Button
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding:
                  EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('Sign Up', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20),

              // Already have an account? Sign In link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text('Sign In', style: TextStyle(color: Colors.deepPurple)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
