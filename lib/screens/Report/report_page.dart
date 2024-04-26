import 'package:flutter/material.dart';
import 'package:guardiancare/screens/Report/incident_type_dropdown.dart';
import 'package:guardiancare/screens/Report/text_input_field.dart';
import 'package:guardiancare/screens/Report/submit_button.dart';
import 'package:guardiancare/screens/utils/email_utils.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late String _selectedIncidentType = 'environmental_safety';
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _recipientEmailController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Incident'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IncidentTypeDropdown(
              selectedIncidentType: _selectedIncidentType,
              onChanged: (value) {
                setState(() {
                  _selectedIncidentType = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            TextInputField(
              controller: _locationController,
              labelText: 'Location *',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            TextInputField(
              controller: _descriptionController,
              labelText: 'Description *',
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            const SizedBox(height: 16),
            TextInputField(
              controller: _recipientEmailController,
              labelText: 'Recipient Email(s) (optional)',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return null;
                }
                final emailRegex = RegExp(r"[^@]+@[^@]+\.[^@]+");
                if (!emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email address.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            SubmitButton(
              onPressed: () {
                _submitReport(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  bool _validateInput() {
    return _locationController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty;
  }

  Future<void> _submitReport(BuildContext context) async {
    if (!_validateInput()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location and Description are required.'),
        ),
      );
      return;
    }

    await sendReportEmail(
      selectedIncidentType: _selectedIncidentType,
      location: _locationController.text,
      description: _descriptionController.text,
      recipientEmail: _recipientEmailController.text,
      context: context,
    );
  }
}
