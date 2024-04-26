import 'package:flutter/material.dart';
import 'package:guardiancare/screens/quizpage/case_title.dart';
import 'package:guardiancare/screens/quizpage/question_list.dart';
import 'package:guardiancare/screens/quizpage/submit_button.dart';

class CaseQuestionsPage extends StatelessWidget {
  final String caseName;
  final List<String> questions;

  const CaseQuestionsPage(this.caseName, this.questions, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(caseName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CaseTitle(caseName: caseName),
            const SizedBox(height: 20),
            QuestionList(questions: questions),
            const SizedBox(height: 20),
            SubmitButton(onPressed: () {
              // Handle submission of answers
            }),
          ],
        ),
      ),
    );
  }
}
