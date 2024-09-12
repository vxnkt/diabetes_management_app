import 'package:appathon/quiz/quizEnd_screen.dart';
import 'package:appathon/quiz/quiz_screen.dart';
import 'package:flutter/material.dart';

class QuizNavigator extends StatefulWidget {
  @override
  _QuizNavigatorState createState() => _QuizNavigatorState();
}

class _QuizNavigatorState extends State<QuizNavigator> {
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'How does regular physical activity help in managing Type 2 diabetes?',
      'options': [
        'It has little impact on managing Type 2 diabetes but helps prevent its onset by improving insulin sensitivity.',
        'It helps muscles absorb more glucose, reduces insulin resistance, and supports weight management, making it essential for both prevention and management.',
        'It only helps manage Type 2 diabetes if combined with medication, having no effect on its own.',
        'Only intense exercise is effective in managing Type 2 diabetes, while moderate activities like walking offer minimal benefits.'
      ],
      'correctAnswer': 'B',
    },
    {
      'question': 'What role does diet play in managing high blood pressure?',
      'options': [
        'Diet has a minimal effect on managing high blood pressure, and medication is the primary treatment.',
        'A diet rich in fruits, vegetables, and low in sodium can help manage high blood pressure and reduce the risk of complications.',
        'Diet is only beneficial if combined with regular exercise; otherwise, it has no significant impact on blood pressure.',
        'Eating large amounts of processed foods is recommended for managing high blood pressure, as it helps balance electrolytes.'
      ],
      'correctAnswer': 'B',
    },
    {
      'question': 'What is the primary benefit of a high-fiber diet in relation to cardiovascular health?',
      'options': [
        'A high-fiber diet primarily helps in improving digestion and does not significantly impact cardiovascular health.',
        'It can help lower cholesterol levels, reduce blood pressure, and decrease the risk of heart disease by promoting healthy blood vessels and reducing inflammation.',
        'A high-fiber diet has minimal effect on cardiovascular health and is mostly beneficial for weight management and blood sugar control.',
        'Only a diet high in saturated fats and low in fiber is effective in managing cardiovascular health.'
      ],
      'correctAnswer': 'B',
    },
    // Add more questions here
  ];

  int questionIndex = 0; // To track the current question index
  int score = 0; // To track the user's score

  void updateQuestion(bool isCorrect) {
    setState(() {
      if (isCorrect) {
        score += 1;
      }
      if (questionIndex < questions.length - 1) {
        questionIndex += 1;
      } else {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuizEndScreen(score: score,)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return QuizScreen(
      question: questions[questionIndex]['question'],
      options: questions[questionIndex]['options'],
      correctAnswer: questions[questionIndex]['correctAnswer'],
      questionIndex: questionIndex,
      totalQuestions: questions.length,
      score: score,
      onAnswerSelected: updateQuestion,
    );
  }
}
