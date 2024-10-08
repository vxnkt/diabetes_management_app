import 'package:flutter/material.dart';

class Medicalhistory extends StatefulWidget {
  const Medicalhistory({super.key});

  @override
  State<Medicalhistory> createState() => _MedicalhistoryState();
}

class _MedicalhistoryState extends State<Medicalhistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Medical History')),
      body: Center(child: Text('Medical History')),
    );
  }
}
