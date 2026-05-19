import 'package:epicare_flutter/core/router/app_routes.dart';
import 'package:epicare_flutter/core/theme/app_colors.dart';
import 'package:epicare_flutter/shared/widgets/app_button.dart';
import 'package:epicare_flutter/shared/widgets/epicare_logo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 18, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(child: EpiCareLogo(width: 230)),
            const SizedBox(height: 48),
            const Text(
              'Log in',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: AppColors.ink),
            ),
            const SizedBox(height: 24),
            const _AuthField(label: 'Email', icon: Icons.mail_outline_rounded),
            const SizedBox(height: 14),
            const _AuthField(label: 'Password', icon: Icons.lock_outline_rounded, obscure: true),
            const SizedBox(height: 12),
            Row(
              children: [
                Checkbox(value: true, onChanged: (_) {}),
                const Text('Remember me'),
                const Spacer(),
                TextButton(onPressed: () {}, child: const Text('Forget password?')),
              ],
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Log In',
              onPressed: () => context.go(AppRoutes.patientHome),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () => context.go(AppRoutes.signUp),
                child: const Text('Don’t have an account? Sign up'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthField extends StatelessWidget {
  const _AuthField({
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
