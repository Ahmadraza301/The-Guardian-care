import 'package:flutter/material.dart';
import 'package:guardiancare/screens/forum/law_descriptions.dart';

class LawDescriptionPage extends StatelessWidget {
  final String lawName;
  final String lawDescription;

  const LawDescriptionPage({super.key,
    required this.lawName,
    required this.lawDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Law Description: $lawName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'About $lawName',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                lawDescription,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'For Children:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                LawDescriptions.generateChildFriendlyExplanation(lawName),
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
