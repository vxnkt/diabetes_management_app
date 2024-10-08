import 'package:flutter/material.dart';

class DoctorsPage extends StatefulWidget {
  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Doctors')),
      body: Center(child: Text('Doctors Screen')),
    );
  }
}
