import 'package:appathon/utils/colors.dart';
import 'package:flutter/material.dart';

class Faq extends StatefulWidget {
  const Faq({super.key});

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Frequently Asked Questions',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: primaryColor),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'FAQs',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 16),
              FaqTile(
                question: 'What is diabetes?',
                answer:
                    'Diabetes is a chronic (long-lasting) health condition that affects how your body turns food into energy.',
              ),
              FaqTile(
                question: 'How do I track my glucose levels?',
                answer:
                    'You can input your glucose levels in the app and track trends over time using graphs.',
              ),
              FaqTile(
                question: 'What is HbA1c?',
                answer:
                    'HbA1c is a blood test that reflects your average blood glucose (sugar) levels over the past three months.',
              ),
              FaqTile(
                question: 'How can I manage my medication?',
                answer:
                    'Use the Medication History feature in the app to log and track your medications.',
              ),
              FaqTile(
                question: 'What should I do if my levels are too high?',
                answer:
                    'Consult with your healthcare provider if your glucose levels are consistently high. The app also provides tips for managing high glucose levels.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FaqTile extends StatelessWidget {
  final String question;
  final String answer;

  const FaqTile({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.blue,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              answer,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
