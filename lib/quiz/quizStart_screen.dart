import 'package:appathon/quiz/quiz_navigator.dart';
import 'package:flutter/material.dart';

class QuizStartScreen extends StatelessWidget {
  const QuizStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Text(
              'The quiz will have a total 3 of questions.',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Text(
                'The final score will be displayed after the quiz ends.',
                style: TextStyle(color: Colors.black, fontSize: 15)),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Text('Press the button below to start the quiz',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 15,
                )),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => QuizNavigator()));
            },
            child: Center(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Start Quiz',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
