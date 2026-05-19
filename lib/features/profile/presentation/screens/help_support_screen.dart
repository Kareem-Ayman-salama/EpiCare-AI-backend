import 'package:epicare_flutter/shared/widgets/app_card.dart';
import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: const [
          _FaqTile(
            question: 'How do I pair my wristband?',
            answer: 'Go to Profile, select My Device, then tap Pair New Device and ensure Bluetooth is on.',
          ),
          _FaqTile(
            question: 'What if my wristband disconnects?',
            answer: 'Ensure your phone is nearby. Go to My Device and tap the disconnected status to reconnect.',
          ),
          _FaqTile(
            question: 'Why did my caregiver not receive an alert?',
            answer: 'Ensure your phone is connected to the internet and your wristband connection is stable.',
          ),
          SizedBox(height: 18),
          Text('For further assistance, contact us at: support@epicare.app'),
        ],
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  const _FaqTile({required this.question, required this.answer});

  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question, style: const TextStyle(fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            Text(answer),
          ],
        ),
      ),
    );
  }
}
