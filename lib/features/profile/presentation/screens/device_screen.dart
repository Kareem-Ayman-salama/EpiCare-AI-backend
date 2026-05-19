import 'package:epicare_flutter/core/theme/app_colors.dart';
import 'package:epicare_flutter/shared/widgets/app_button.dart';
import 'package:epicare_flutter/shared/widgets/app_card.dart';
import 'package:flutter/material.dart';

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const isPaired = true;

    return Scaffold(
      appBar: AppBar(title: const Text('My Device')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          if (isPaired)
            AppCard(
              child: Column(
                children: [
                  const Icon(Icons.watch_rounded, color: AppColors.primary, size: 90),
                  const SizedBox(height: 12),
                  const Text('EpiCare-Band-123', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 10),
                  const _InfoRow(label: 'Connection Status', value: 'Connected'),
                  const _InfoRow(label: 'Battery Level', value: '82%'),
                  const SizedBox(height: 16),
                  AppButton(label: 'Unpair Device', outlined: true, onPressed: () {}),
                ],
              ),
            )
          else
            AppCard(
              child: Column(
                children: [
                  const Icon(Icons.watch_off_rounded, color: AppColors.primary, size: 90),
                  const Text('No Device Paired', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 8),
                  const Text('To start monitoring, please pair your EpiCare wristband.', textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  AppButton(label: 'Pair New Device', icon: Icons.add_rounded, onPressed: () {}),
                ],
              ),
            ),
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(color: AppColors.muted))),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}
