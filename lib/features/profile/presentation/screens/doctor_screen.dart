import 'package:epicare_flutter/core/theme/app_colors.dart';
import 'package:epicare_flutter/shared/widgets/app_button.dart';
import 'package:epicare_flutter/shared/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Doctor')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'Ask your doctor to scan your personal QR Code using their dedicated app.',
            style: TextStyle(color: AppColors.muted, height: 1.4),
          ),
          const SizedBox(height: 18),
          AppCard(
            child: Center(
              child: QrImageView(
                data: 'epicare://doctor-link/sara-2048',
                size: 210,
              ),
            ),
          ),
          const SizedBox(height: 18),
          AppCard(
            child: Column(
              children: [
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(child: Icon(Icons.medical_services_rounded)),
                  title: Text('Dr. Lina Morris'),
                  subtitle: Text('Neurologist'),
                ),
                AppButton(label: 'Start Chat', onPressed: () {}),
                const SizedBox(height: 8),
                AppButton(label: 'Unlink', outlined: true, onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
