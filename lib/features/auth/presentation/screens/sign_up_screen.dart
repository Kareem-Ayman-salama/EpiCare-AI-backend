import 'package:epicare_flutter/core/router/app_routes.dart';
import 'package:epicare_flutter/core/theme/app_colors.dart';
import 'package:epicare_flutter/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 42,
              backgroundColor: AppColors.line,
              child: Icon(Icons.person_rounded, color: AppColors.primary, size: 46),
            ),
            const SizedBox(height: 22),
            const _Field(label: 'User name', icon: Icons.person_outline_rounded),
            const SizedBox(height: 12),
            const _Field(label: 'Email Address', icon: Icons.mail_outline_rounded),
            const SizedBox(height: 12),
            const _Field(label: 'Phone Number', icon: Icons.phone_outlined),
            const SizedBox(height: 12),
            const _Field(label: 'Password', icon: Icons.lock_outline_rounded, obscure: true),
            const SizedBox(height: 12),
            const _Field(label: 'Confirm password', icon: Icons.lock_reset_rounded, obscure: true),
            const SizedBox(height: 24),
            AppButton(
              label: 'Create Account',
              onPressed: () => context.go(AppRoutes.otp),
            ),
            const SizedBox(height: 18),
            TextButton(
              onPressed: () => context.go(AppRoutes.signIn),
              child: const Text('Have an account? Log in'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.icon,
    this.obscure = false,
  });

  final String label;
  final IconData icon;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.line),
        ),
      ),
    );
  }
}
