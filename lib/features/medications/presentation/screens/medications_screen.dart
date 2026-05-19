import 'package:epicare_flutter/core/router/app_routes.dart';
import 'package:epicare_flutter/core/theme/app_colors.dart';
import 'package:epicare_flutter/shared/widgets/app_card.dart';
import 'package:epicare_flutter/shared/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MedicationsScreen extends StatelessWidget {
  const MedicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medications')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
        children: [
          const _ProgressCard(),
          const SizedBox(height: 22),
          const SectionHeader(title: "Today's Doses"),
          const SizedBox(height: 10),
          const _DoseTile(time: '08:00 AM', name: 'Levetiracetam', status: 'Taken on-time', color: AppColors.success),
          const _DoseTile(time: '02:00 PM', name: 'Lamotrigine', status: 'Upcoming', color: AppColors.primary),
          const _DoseTile(time: '09:30 PM', name: 'Levetiracetam', status: 'Upcoming', color: AppColors.primary),
          const SizedBox(height: 22),
          SectionHeader(
            title: 'My Medications',
            actionLabel: 'Log',
            onAction: () => context.push(AppRoutes.medicationLog),
          ),
          const SizedBox(height: 10),
          _MedicationTile(
            name: 'Levetiracetam',
            dose: '500 mg',
            instructions: 'Take after food',
            onTap: () => context.push(AppRoutes.medicationDetails),
          ),
          _MedicationTile(
            name: 'Lamotrigine',
            dose: '100 mg',
            instructions: 'Do not skip doses',
            onTap: () => context.push(AppRoutes.medicationDetails),
          ),
        ],
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Today's Progress", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: const LinearProgressIndicator(
              minHeight: 12,
              value: .66,
              backgroundColor: AppColors.line,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 10),
          const Text('2 of 3 doses completed', style: TextStyle(color: AppColors.muted)),
        ],
      ),
    );
  }
}

class _DoseTile extends StatelessWidget {
  const _DoseTile({
    required this.time,
    required this.name,
    required this.status,
    required this.color,
  });

  final String time;
  final String name;
  final String status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppCard(
        child: Row(
          children: [
            const Icon(Icons.medication_rounded, color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.w800)),
                  Text(time, style: const TextStyle(color: AppColors.muted)),
                ],
              ),
            ),
            Chip(
              label: Text(status),
              backgroundColor: color.withOpacity(.12),
              labelStyle: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

class _MedicationTile extends StatelessWidget {
  const _MedicationTile({
    required this.name,
    required this.dose,
    required this.instructions,
    required this.onTap,
  });

  final String name;
  final String dose;
  final String instructions;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppCard(
        onTap: onTap,
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: AppColors.subtle,
              child: Icon(Icons.local_pharmacy_rounded, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.w900)),
                  Text('$dose • $instructions', style: const TextStyle(color: AppColors.muted)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }
}
