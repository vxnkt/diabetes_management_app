import 'package:flutter/material.dart';

class DocHomepage extends StatefulWidget {
  const DocHomepage({super.key});

  @override
  State<DocHomepage> createState() => _DocHomepageState();
}

class _DocHomepageState extends State<DocHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centers vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Centers horizontally
          children: [
            Text(
              'DOCTOR HOME PAGE',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
