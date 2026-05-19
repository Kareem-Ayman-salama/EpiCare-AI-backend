import 'package:epicare_flutter/core/router/app_routes.dart';
import 'package:epicare_flutter/core/theme/app_colors.dart';
import 'package:epicare_flutter/shared/widgets/app_button.dart';
import 'package:epicare_flutter/shared/widgets/app_card.dart';
import 'package:epicare_flutter/shared/widgets/section_header.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

class SeizureLogScreen extends StatelessWidget {
  const SeizureLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seizure History')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddSeizureSheet(context),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Log Seizure'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Row(
            children: [
              Expanded(child: _StatCard(title: 'Total', value: '8')),
              SizedBox(width: 10),
              Expanded(child: _StatCard(title: 'Avg duration', value: '1m 42s')),
            ],
          ),
          const SizedBox(height: 10),
          const _StatCard(title: 'Most frequent time', value: 'Evening'),
          const SizedBox(height: 22),
          AppCard(
            child: TableCalendar<void>(
              firstDay: DateTime.utc(2026, 1, 1),
              lastDay: DateTime.utc(2026, 12, 31),
              focusedDay: DateTime.now(),
              headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
            ),
          ),
          const SizedBox(height: 22),
          const SectionHeader(title: 'Monthly Trend'),
          const SizedBox(height: 10),
          AppCard(
            child: SizedBox(
              height: 180,
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  gridData: const FlGridData(show: false),
                  barGroups: [
                    _bar(0, 2),
                    _bar(1, 5),
                    _bar(2, 3),
                    _bar(3, 7),
                    _bar(4, 4),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 22),
          SectionHeader(title: 'Full History', actionLabel: 'Filter', onAction: () {}),
          const SizedBox(height: 10),
          _SeizureTile(
            date: 'May 15, 2026',
            startTime: '08:32 PM',
            duration: '1m 20s',
            onTap: () => context.push(AppRoutes.seizureDetails),
          ),
          _SeizureTile(
            date: 'May 11, 2026',
            startTime: '06:05 PM',
            duration: '2m 04s',
            onTap: () => context.push(AppRoutes.seizureDetails),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  static BarChartGroupData _bar(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: AppColors.primary,
          width: 18,
          borderRadius: BorderRadius.circular(6),
        ),
      ],
    );
  }

  void _showAddSeizureSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(20, 8, 20, MediaQuery.of(context).viewInsets.bottom + 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Add Seizure Manually', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
              const SizedBox(height: 16),
              const TextField(decoration: InputDecoration(labelText: 'Start Time & Date')),
              const SizedBox(height: 10),
              const TextField(decoration: InputDecoration(labelText: 'Duration')),
              const SizedBox(height: 10),
              const TextField(maxLines: 3, decoration: InputDecoration(labelText: 'Notes')),
              const SizedBox(height: 18),
              AppButton(label: 'Save Seizure', onPressed: () => Navigator.pop(context)),
              const SizedBox(height: 10),
              AppButton(label: 'Cancel', outlined: true, onPressed: () => Navigator.pop(context)),
            ],
          ),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: AppColors.muted)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

class _SeizureTile extends StatelessWidget {
  const _SeizureTile({
    required this.date,
    required this.startTime,
    required this.duration,
    required this.onTap,
  });

  final String date;
  final String startTime;
  final String duration;
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
              child: Icon(Icons.monitor_heart_rounded, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(date, style: const TextStyle(fontWeight: FontWeight.w900)),
                  Text('$startTime • $duration', style: const TextStyle(color: AppColors.muted)),
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
