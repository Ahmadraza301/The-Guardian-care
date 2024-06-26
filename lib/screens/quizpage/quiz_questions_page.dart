import 'package:flutter/material.dart';

class QuizQuestionsPage extends StatefulWidget {
  final List<Map<String, dynamic>> questions;

  const QuizQuestionsPage({super.key, required this.questions});

  @override
  _QuizQuestionsPageState createState() => _QuizQuestionsPageState();
}

class _QuizQuestionsPageState extends State<QuizQuestionsPage> {
  int currentQuestionIndex = 0; // Index of the current question
  int correctAnswers = 0; // Number of correct answers

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Questions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${currentQuestionIndex + 1}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.questions[currentQuestionIndex]['question'],
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(
              widget.questions[currentQuestionIndex]['options'].length,
                  (index) => ElevatedButton(
                onPressed: () {
                  // Check if the selected option is correct
                  if (index ==
                      widget.questions[currentQuestionIndex]
                      ['correctAnswerIndex']) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Correct!'),
                    ));
                    setState(() {
                      correctAnswers++;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Incorrect!'),
                    ));
                  }
                  // Move to the next question after a short delay
                  Future.delayed(const Duration(seconds: 2), () {
                    setState(() {
                      if (currentQuestionIndex <
                          widget.questions.length - 1) {
                        currentQuestionIndex++;
                      } else {
                        // Show a dialog with the score
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Quiz Completed'),
                              content: Text(
                                  'You have completed the quiz!\n\nYour score: $correctAnswers/${widget.questions.length}'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.popUntil(context, ModalRoute.withName('/'));
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    });
                  });
                },
                child: Text(widget.questions[currentQuestionIndex]['options']
                [index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
