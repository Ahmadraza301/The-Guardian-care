import 'package:flutter/material.dart';

class EmergencyContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> contacts;

  const EmergencyContactCard({
    super.key,
    required this.icon,
    required this.title,
    required this.contacts,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 48,
                  color: Colors.blue,
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: contacts
                  .map((contact) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  contact,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
