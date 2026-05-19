import 'package:epicare_flutter/core/theme/app_colors.dart';
import 'package:epicare_flutter/shared/widgets/app_card.dart';
import 'package:epicare_flutter/shared/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MedicationLogScreen extends StatelessWidget {
  const MedicationLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medication Log')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          AppCard(
            child: TableCalendar<void>(
              firstDay: DateTime.utc(2026, 1, 1),
              lastDay: DateTime.utc(2026, 12, 31),
              focusedDay: DateTime.now(),
              headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
              ),
            ),
          ),
          const SizedBox(height: 22),
          const SectionHeader(title: 'History Feed'),
          const SizedBox(height: 10),
          const _HistoryTile(name: 'Levetiracetam', status: 'Taken on-time', timestamp: 'Today, 08:03 AM', color: AppColors.success),
          const _HistoryTile(name: 'Lamotrigine', status: 'Missed', timestamp: 'Yesterday, 02:00 PM', color: AppColors.danger),
          const _HistoryTile(name: 'Levetiracetam', status: 'Taken late', timestamp: 'Yesterday, 09:58 PM', color: AppColors.warning),
        ],
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({
    required this.name,
    required this.status,
    required this.timestamp,
    required this.color,
  });

  final String name;
  final String status;
  final String timestamp;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppCard(
        child: Row(
          children: [
            Icon(Icons.circle, color: color, size: 16),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.w800)),
                  Text(timestamp, style: const TextStyle(color: AppColors.muted, fontSize: 13)),
                ],
              ),
            ),
            Text(status, style: TextStyle(color: color, fontWeight: FontWeight.w800)),
          ],
        ),
      ),
    );
  }
}
