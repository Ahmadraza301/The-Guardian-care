import 'package:flutter/material.dart';

class CaseTitle extends StatelessWidget {
  final String caseName;

  const CaseTitle({super.key, required this.caseName});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Report $caseName',
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
