import 'package:epicare_flutter/core/router/app_routes.dart';
import 'package:epicare_flutter/core/theme/app_colors.dart';
import 'package:epicare_flutter/shared/widgets/app_button.dart';
import 'package:epicare_flutter/shared/widgets/app_card.dart';
import 'package:epicare_flutter/shared/widgets/epicare_logo.dart';
import 'package:epicare_flutter/shared/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
          children: [
            Row(
              children: [
                const EpiCareLogo(width: 150, textSize: 25),
                const Spacer(),
                IconButton.filledTonal(onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),
                const SizedBox(width: 8),
                IconButton.filledTonal(onPressed: () {}, icon: const Icon(Icons.person_outline_rounded)),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Good Morning, Sara',
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900, color: AppColors.ink),
            ),
            const SizedBox(height: 18),
            const _ConnectionStatusCard(isConnected: true),
            const SizedBox(height: 18),
            _PredictionCard(onRunPrediction: () => context.push(AppRoutes.seizurePrediction)),
            const SizedBox(height: 22),
            const SectionHeader(title: 'Recent Alerts'),
            const SizedBox(height: 10),
            const _AlertTile(
              icon: Icons.bluetooth_disabled_rounded,
              title: 'Device alert',
              subtitle: 'Wristband disconnected for 2 minutes',
              color: AppColors.offline,
            ),
            const _AlertTile(
              icon: Icons.medication_outlined,
              title: 'Medication alert',
              subtitle: 'Lamotrigine reminder snoozed',
              color: AppColors.warning,
            ),
            const _AlertTile(
              icon: Icons.warning_amber_rounded,
              title: 'Seizure warning',
              subtitle: 'High-risk event reviewed yesterday',
              color: AppColors.danger,
            ),
            const SizedBox(height: 22),
            SectionHeader(title: 'Quick Tips', actionLabel: 'View All', onAction: () {}),
            const SizedBox(height: 10),
            const _TipCard(),
          ],
        ),
      ),
    );
  }
}

class _ConnectionStatusCard extends StatelessWidget {
  const _ConnectionStatusCard({required this.isConnected});

  final bool isConnected;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: isConnected ? Colors.white : const Color(0xFFF4F1F4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isConnected ? Icons.check_circle_rounded : Icons.link_off_rounded,
                color: isConnected ? AppColors.success : AppColors.offline,
              ),
              const SizedBox(width: 8),
              Text(
                isConnected ? 'Connected' : 'Offline',
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
              ),
              const Spacer(),
              Text(
                isConnected ? 'Safe' : 'Tap to reconnect',
                style: TextStyle(color: isConnected ? AppColors.success : AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Expanded(child: _VitalChip(label: 'ECG', value: 'Normal')),
              SizedBox(width: 8),
              Expanded(child: _VitalChip(label: 'EMG', value: 'Normal')),
              SizedBox(width: 8),
              Expanded(child: _VitalChip(label: 'Mov', value: 'Normal')),
            ],
          ),
        ],
      ),
    );
  }
}

class _VitalChip extends StatelessWidget {
  const _VitalChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.subtle,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: AppColors.muted, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class _PredictionCard extends StatelessWidget {
  const _PredictionCard({required this.onRunPrediction});

  final VoidCallback onRunPrediction;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: AppColors.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.monitor_heart_rounded, color: Colors.white, size: 36),
          const SizedBox(height: 12),
          const Text(
            '30-minute early warning',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 6),
          const Text(
            'AI prediction uses EEG, ECG, and EMG signals to estimate seizure risk.',
            style: TextStyle(color: Colors.white, height: 1.35),
          ),
          const SizedBox(height: 14),
          AppButton(
            label: 'Check risk',
            onPressed: onRunPrediction,
            outlined: true,
          ),
        ],
      ),
    );
  }
}

class _AlertTile extends StatelessWidget {
  const _AlertTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppCard(
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(.12),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 3),
                  Text(subtitle, style: const TextStyle(color: AppColors.muted, fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  const _TipCard();

  @override
  Widget build(BuildContext context) {
    return const AppCard(
      child: Row(
        children: [
          Icon(Icons.pool_rounded, color: AppColors.primary, size: 42),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Swimming safety', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
                SizedBox(height: 5),
                Text(
                  'Avoid swimming alone and keep your caregiver informed.',
                  style: TextStyle(color: AppColors.muted, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
