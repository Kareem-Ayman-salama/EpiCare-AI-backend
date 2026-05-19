import 'package:epicare_flutter/core/router/app_routes.dart';
import 'package:epicare_flutter/core/theme/app_colors.dart';
import 'package:epicare_flutter/shared/widgets/app_button.dart';
import 'package:epicare_flutter/shared/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key, this.isProfileHub = false});

  final bool isProfileHub;

  @override
  Widget build(BuildContext context) {
    if (isProfileHub) return const _ProfileHub();

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const CircleAvatar(radius: 42, child: Icon(Icons.person_rounded, size: 48)),
          const SizedBox(height: 22),
          const _Field(label: 'Name'),
          const _Field(label: 'Email'),
          const _Field(label: 'Phone Number'),
          const SizedBox(height: 16),
          AppButton(label: 'Save Changes', onPressed: () {}),
          const SizedBox(height: 10),
          AppButton(label: 'Change Password', outlined: true, onPressed: () {}),
        ],
      ),
    );
  }
}

class _ProfileHub extends StatelessWidget {
  const _ProfileHub();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          AppCard(
            child: Column(
              children: [
                const CircleAvatar(radius: 42, child: Icon(Icons.person_rounded, size: 48)),
                const SizedBox(height: 12),
                const Text('Sara Mohamed', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                const Text('sara@example.com', style: TextStyle(color: AppColors.muted)),
                const SizedBox(height: 14),
                ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: const LinearProgressIndicator(
                    minHeight: 10,
                    value: .75,
                    backgroundColor: AppColors.line,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Profile Strength: 75% - Add a caregiver to reach 100%'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _MenuTile(title: 'Edit Profile', icon: Icons.edit_outlined, route: AppRoutes.editProfile),
          _MenuTile(title: 'My Caregiver', icon: Icons.groups_rounded, route: AppRoutes.caregiver),
          _MenuTile(title: 'My Doctor', icon: Icons.medical_services_outlined, route: AppRoutes.doctor),
          _MenuTile(title: 'My Device', icon: Icons.watch_rounded, route: AppRoutes.device),
          _MenuTile(title: 'Notification Settings', icon: Icons.notifications_outlined, route: AppRoutes.notificationSettings),
          _MenuTile(title: 'Help & Support', icon: Icons.help_outline_rounded, route: AppRoutes.helpSupport),
          const SizedBox(height: 12),
          AppButton(label: 'Log out', outlined: true, onPressed: () => context.go(AppRoutes.signIn)),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({required this.title, required this.icon, required this.route});

  final String title;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppCard(
        onTap: () => context.push(route),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w800))),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.line),
          ),
        ),
      ),
    );
  }
}
