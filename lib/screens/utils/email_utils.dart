import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

Future<void> sendReportEmail({
  required String selectedIncidentType,
  required String location,
  required String description,
  required String recipientEmail, required BuildContext context,
}) async {
  final emailBody = StringBuffer();
  emailBody.write('Incident Type: $selectedIncidentType\n');
  emailBody.write('Location: $location\n');
  emailBody.write('Description: $description\n');

  final emailRecipient = recipientEmail.isNotEmpty ? recipientEmail : 'mohdumair.a@somaiya.edu';
  final email = Email(
    subject: 'Incident Report',
    body: emailBody.toString(),
    recipients: [emailRecipient],
  );

  try {
    await FlutterEmailSender.send(email);
    // Return a successful result
  } catch (error) {
    // Return an error result
    rethrow;
  }
}
