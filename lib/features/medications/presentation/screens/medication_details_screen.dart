import 'package:epicare_flutter/core/theme/app_colors.dart';
import 'package:epicare_flutter/shared/widgets/app_button.dart';
import 'package:epicare_flutter/shared/widgets/app_card.dart';
import 'package:flutter/material.dart';

class MedicationDetailsScreen extends StatelessWidget {
  const MedicationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Levetiracetam')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Icon(Icons.local_pharmacy_rounded, color: AppColors.primary, size: 96),
          const SizedBox(height: 18),
          const AppCard(
            child: Column(
              children: [
                _InfoRow(label: 'Dose', value: '500 mg'),
                _InfoRow(label: 'Instructions', value: 'Take after food'),
                _InfoRow(label: 'Frequency', value: 'Twice daily'),
                _InfoRow(label: 'Main Reminder', value: '08:00 AM'),
                _InfoRow(label: 'Follow-up Reminder', value: '30 minutes later'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          AppCard(
            child: SwitchListTile(
              value: true,
              onChanged: (_) {},
              contentPadding: EdgeInsets.zero,
              title: const Text('Notify Caregiver'),
              subtitle: const Text('Notify my caregiver when I miss this medication.'),
            ),
          ),
          const SizedBox(height: 24),
          AppButton(label: 'Save', onPressed: () {}),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(color: AppColors.muted))),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
