import 'package:appathon/screens/home_page.dart';
import 'package:appathon/quiz/quizStart_screen.dart';
import 'package:appathon/quiz/quiz_navigator.dart';
import 'package:flutter/material.dart';

class QuizEndScreen extends StatelessWidget {
  final int score;
  const QuizEndScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Image.network(
                  'https://cdn.pixabay.com/photo/2016/10/10/01/49/hook-1727484_640.png')),
          Container(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Text(
                'Congratulations you have successfully finished this quiz.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Text(
                'Your total score is: ${score}',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Exit Quiz',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => QuizNavigator()));
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Retake Quiz',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
