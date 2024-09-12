import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  final String question; // To hold the question text
  final List<String> options; // To hold a list of answers (A, B, C, D)
  final String correctAnswer; // To hold the correct answer
  final int questionIndex; // Index of the current question
  final int totalQuestions; // Total number of questions
  final int score; // Current score
  final Function(bool) onAnswerSelected; // Callback to handle answer selection

  // Constructor to take question, options, and correct answer as required parameters
  const QuizScreen({
    super.key,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.questionIndex,
    required this.totalQuestions,
    required this.score,
    required this.onAnswerSelected,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String? selectedOption; // Variable to track the selected option (e.g., 'A', 'B', 'C', 'D')
  bool showFeedback = false; // Whether to show correct/incorrect feedback

  // Method to check the answer and update the score
  void checkAnswer(String selectedOption) {
    bool isCorrect = selectedOption == widget.correctAnswer;
    widget.onAnswerSelected(isCorrect);
    setState(() {
      showFeedback = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Exit Quiz'),
                content: Text('Are you sure you want to exit the quiz?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.of(context).pop(); // Go back to the previous screen
                    },
                    child: Text('Yes'),
                  ),
                ],
              ),
            );
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Quiz',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Display the score
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: Text(
                  'Score: ${widget.score}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              // Display the question
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Question ${widget.questionIndex + 1}/${widget.totalQuestions}: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.deepPurple,
                    ),
                    children: [
                      TextSpan(
                        text: widget.question,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Display the options
              ...widget.options.asMap().entries.map((entry) {
                int index = entry.key;
                String option = entry.value;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedOption = String.fromCharCode(65 + index); // 'A', 'B', 'C', 'D'
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: selectedOption == String.fromCharCode(65 + index) ? Color(0xFFCBC3E3) : Colors.black,
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: 'Option ${String.fromCharCode(65 + index)}: ',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.deepPurple,
                        ),
                        children: [
                          TextSpan(
                            text: option,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
              // Show feedback after the user selects an option
              if (showFeedback)
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    selectedOption == widget.correctAnswer
                        ? 'Correct!'
                        : 'Incorrect! The correct answer is: ${widget.correctAnswer}',
                    style: TextStyle(
                      color: selectedOption == widget.correctAnswer ? Colors.green : Colors.red,
                      fontSize: 18,
                    ),
                  ),
                ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    GestureDetector(
                      onTap: () {
                        setState(() {
                          checkAnswer(selectedOption!);
                          showFeedback = false;
                          selectedOption = null;
                          // Reset for next question
                        });
                      },
                      child: Text(
                        'Go to the Next Question',
                        style: TextStyle(color: Colors.deepPurple, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
