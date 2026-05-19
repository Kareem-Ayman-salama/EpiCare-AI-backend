import 'package:epicare_flutter/shared/widgets/app_card.dart';
import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Settings')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: const [
          _SettingTile(title: 'Medication Reminders', description: 'Alarm-like notifications for daily medication times.'),
          _SettingTile(title: 'Device Alerts', description: 'Notify if wristband connection is lost or battery is low.'),
          _SettingTile(title: 'Chat Notifications', description: 'Notify me when my doctor sends a new message.'),
          _SettingTile(title: 'Daily Tips', description: 'Receive a daily helpful safety tip.'),
        ],
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  const _SettingTile({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppCard(
        child: SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: true,
          onChanged: (_) {},
          title: Text(title),
          subtitle: Text(description),
        ),
      ),
    );
  }
}
