import 'package:epicare_flutter/core/theme/app_colors.dart';
import 'package:epicare_flutter/shared/widgets/app_button.dart';
import 'package:epicare_flutter/shared/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CaregiverScreen extends StatelessWidget {
  const CaregiverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Caregiver')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'Ask your caregiver to scan your QR code using their app.',
            style: TextStyle(color: AppColors.muted, height: 1.4),
          ),
          const SizedBox(height: 18),
          AppCard(
            child: Center(
              child: QrImageView(
                data: 'epicare://patient/sara-2048',
                size: 210,
              ),
            ),
          ),
          const SizedBox(height: 18),
          const AppCard(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(child: Icon(Icons.person_rounded)),
              title: Text('Mona Mohamed'),
              subtitle: Text('Mother • +20 100 000 0000'),
              trailing: Switch(value: true, onChanged: null),
            ),
          ),
          const SizedBox(height: 18),
          AppButton(label: 'Add Another Caregiver', onPressed: () {}),
        ],
      ),
    );
  }
}
