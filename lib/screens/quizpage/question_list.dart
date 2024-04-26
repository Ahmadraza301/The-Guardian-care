import 'package:flutter/material.dart';
import 'package:guardiancare/screens/quizpage/checkbox_item.dart';
// ignore: duplicate_import
import 'package:guardiancare/screens/quizpage/checkbox_item.dart'; // Adjust the package name

class QuestionList extends StatelessWidget {
  final List<String> questions;

  const QuestionList({super.key, required this.questions});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: questions.map((question) {
        return CheckboxItem(question: question);
      }).toList(),
    );
  }
}
