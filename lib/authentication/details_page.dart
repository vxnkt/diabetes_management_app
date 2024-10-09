import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../firebase/auth_methods.dart';
import '../screens/home_page.dart';


class MedicalDetailsPage extends StatefulWidget {
  @override
  _MedicalDetailsPageState createState() => _MedicalDetailsPageState();
}

class _MedicalDetailsPageState extends State<MedicalDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  String? _diabetesType;
  String? _diabetesDuration;
  bool _hasHypertension = false;
  bool _hasThyroid = false;
  bool _hasKidneyProblems = false;
  bool _hasRespiratoryProblems = false;
  bool _hasNeuroRelated = false;
  bool _hasPsychiatricRelated = false;
  String? _otherMedicalHistory;

  String? _pastMedicationHistory;

  bool _hasRBSValue = false;
  String? _rbsValue;

  bool _hasHbA1CValue = false;
  String? _hbA1CValue;

  // List of complications
  List<String> _complications = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Details'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Diabetes Type
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Type of Diabetes'),
                items: ['Type-1', 'Type-2', 'Gestational Diabetes']
                    .map((type) => DropdownMenuItem(
                  value: type,
                  child: Text(type),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _diabetesType = value;
                  });
                },
                validator: (value) =>
                value == null ? 'Please select a type' : null,
              ),
              SizedBox(height: 16),

              // Duration of Diabetes
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Duration of Diabetes'),
                items: [
                  'Less than 6 months',
                  '12 months (1 year)',
                  '2 years',
                  '3 years',
                  '4 years',
                  '5 years',
                  '6 years',
                  '7 years',
                  '8 years',
                  '9 years',
                  '10 years',
                  '11 years',
                  '12 or more years'
                ]
                    .map((duration) => DropdownMenuItem(
                  value: duration,
                  child: Text(duration),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _diabetesDuration = value;
                  });
                },
                validator: (value) =>
                value == null ? 'Please select a duration' : null,
              ),
              SizedBox(height: 16),

              // Past Medical History
              Text('Past Medical History',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              CheckboxListTile(
                title: Text('Hypertension (B.P)'),
                value: _hasHypertension,
                onChanged: (value) {
                  setState(() {
                    _hasHypertension = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Thyroid'),
                value: _hasThyroid,
                onChanged: (value) {
                  setState(() {
                    _hasThyroid = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Kidney Problems (AKD, CKD, UTI, Other)'),
                value: _hasKidneyProblems,
                onChanged: (value) {
                  setState(() {
                    _hasKidneyProblems = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Respiratory Problems (Asthma, COPD, Other)'),
                value: _hasRespiratoryProblems,
                onChanged: (value) {
                  setState(() {
                    _hasRespiratoryProblems = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Neuro Related (Stroke, Epilepsy, Parkinson\'s)'),
                value: _hasNeuroRelated,
                onChanged: (value) {
                  setState(() {
                    _hasNeuroRelated = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Psychiatric Related'),
                value: _hasPsychiatricRelated,
                onChanged: (value) {
                  setState(() {
                    _hasPsychiatricRelated = value!;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Other Medical History'),
                onChanged: (value) {
                  setState(() {
                    _otherMedicalHistory = value;
                  });
                },
              ),
              SizedBox(height: 16),

              // Past Medication History
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Past Medication History (Optional)'),
                onChanged: (value) {
                  setState(() {
                    _pastMedicationHistory = value;
                  });
                },
              ),
              SizedBox(height: 16),

              // RBS Value
              CheckboxListTile(
                title: Text('Last time RBS Value'),
                value: _hasRBSValue,
                onChanged: (value) {
                  setState(() {
                    _hasRBSValue = value!;
                  });
                },
              ),
              if (_hasRBSValue)
                TextFormField(
                  decoration: InputDecoration(labelText: 'RBS Value'),
                  onChanged: (value) {
                    setState(() {
                      _rbsValue = value;
                    });
                  },
                ),
              SizedBox(height: 16),

              // HbA1C Value
              CheckboxListTile(
                title: Text('Last time HbA1C Value'),
                value: _hasHbA1CValue,
                onChanged: (value) {
                  setState(() {
                    _hasHbA1CValue = value!;
                  });
                },
              ),
              if (_hasHbA1CValue)
                TextFormField(
                  decoration: InputDecoration(labelText: 'HbA1C Value'),
                  onChanged: (value) {
                    setState(() {
                      _hbA1CValue = value;
                    });
                  },
                ),
              SizedBox(height: 16),

              // Complications
              Text('Do you have any of the following?',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              CheckboxListTile(
                title: Text('Presence of peripheral neuropathy'),
                value: _complications.contains('Peripheral neuropathy'),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      _complications.add('Peripheral neuropathy');
                    } else {
                      _complications.remove('Peripheral neuropathy');
                    }
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Peripheral arterial disease (PAD)'),
                value: _complications.contains('Peripheral arterial disease (PAD)'),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      _complications.add('Peripheral arterial disease (PAD)');
                    } else {
                      _complications.remove('Peripheral arterial disease (PAD)');
                    }
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Foot deformities'),
                value: _complications.contains('Foot deformities'),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      _complications.add('Foot deformities');
                    } else {
                      _complications.remove('Foot deformities');
                    }
                  });
                },
              ),
              CheckboxListTile(
                title: Text('History of foot ulcers or amputation'),
                value: _complications.contains('Foot ulcers or amputation'),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      _complications.add('Foot ulcers or amputation');
                    } else {
                      _complications.remove('Foot ulcers or amputation');
                    }
                  });
                },
              ),
              SizedBox(height: 30),

              // Submit Button
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Create a map of the form data to send to Firestore
                    Map<String, dynamic> medicalDetails = {
                      'diabetesType': _diabetesType,
                      'diabetesDuration': _diabetesDuration,
                      'hasHypertension': _hasHypertension,
                      'hasThyroid': _hasThyroid,
                      'hasKidneyProblems': _hasKidneyProblems,
                      'hasRespiratoryProblems': _hasRespiratoryProblems,
                      'hasNeuroRelated': _hasNeuroRelated,
                      'hasPsychiatricRelated': _hasPsychiatricRelated,
                      'otherMedicalHistory': _otherMedicalHistory,
                      'pastMedicationHistory': _pastMedicationHistory,
                      'hasRBSValue': _hasRBSValue,
                      'rbsValue': _rbsValue,
                      'hasHbA1CValue': _hasHbA1CValue,
                      'hbA1CValue': _hbA1CValue,
                      'complications': _complications,
                    };

                    // Call the method from AuthMethods to store the data
                    AuthMethods authMethods = AuthMethods();
                    User? user = FirebaseAuth.instance.currentUser; // Get the current user
                    if (user != null) {
                      await authMethods.saveMedicalDetails(uid: user.uid, medicalDetails: medicalDetails);
                      print('Medical Details Submitted');

                      // Navigate to HomePage after submission
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } else {
                      print('No user signed in');
                    }
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
