import 'package:epicare_flutter/core/theme/app_colors.dart';
import 'package:epicare_flutter/shared/widgets/app_card.dart';
import 'package:epicare_flutter/shared/widgets/section_header.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SeizureDetailsScreen extends StatelessWidget {
  const SeizureDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seizure Details')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const AppCard(
            child: Column(
              children: [
                _InfoRow(label: 'Date & Day', value: 'Friday, May 15'),
                _InfoRow(label: 'Start Time', value: '08:32 PM'),
                _InfoRow(label: 'End Time', value: '08:34 PM'),
                _InfoRow(label: 'Duration', value: '1m 20s'),
                _InfoRow(label: 'Location', value: 'Home'),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const SectionHeader(title: 'Vital Signs'),
          const SizedBox(height: 10),
          const _SignalChart(title: 'EEG Research Data'),
          const _SignalChart(title: 'ECG'),
          const _SignalChart(title: 'EMG'),
          const _SignalChart(title: 'Movement'),
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
          Flexible(child: Text(value, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.w800))),
        ],
      ),
    );
  }
}

class _SignalChart extends StatelessWidget {
  const _SignalChart({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
            const SizedBox(height: 12),
            SizedBox(
              height: 110,
              child: LineChart(
                LineChartData(
                  titlesData: const FlTitlesData(show: false),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      color: AppColors.primary,
                      dotData: const FlDotData(show: false),
                      spots: const [
                        FlSpot(0, 1),
                        FlSpot(1, 1.8),
                        FlSpot(2, 1.1),
                        FlSpot(3, 2.4),
                        FlSpot(4, 1.3),
                        FlSpot(5, 2.0),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
