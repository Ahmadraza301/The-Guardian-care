import 'package:flutter/material.dart';

class IncidentTypeDropdown extends StatelessWidget {
  final String selectedIncidentType;
  final ValueChanged<String?> onChanged;

  const IncidentTypeDropdown({super.key,
    required this.selectedIncidentType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Select Incident Type *:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedIncidentType,
          items: const [
            DropdownMenuItem(
              value: 'environmental_safety',
              child: Text('Environmental Safety'),
            ),
            DropdownMenuItem(
              value: 'online_safety',
              child: Text('Online Safety'),
            ),
          ],
          onChanged: onChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Select Incident Type',
          ),
        ),
      ],
    );
  }
}
