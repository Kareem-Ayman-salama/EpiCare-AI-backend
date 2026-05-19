import 'package:epicare_flutter/core/router/app_routes.dart';
import 'package:epicare_flutter/core/theme/app_colors.dart';
import 'package:epicare_flutter/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verification')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter OTP',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 10),
            const Text(
              'We sent a verification code to your email.',
              style: TextStyle(color: AppColors.muted, fontSize: 16),
            ),
            const SizedBox(height: 36),
            Row(
              children: List.generate(
                4,
                (index) => const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: InputDecoration(counterText: ''),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            AppButton(
              label: 'Verify',
              onPressed: () => context.go(AppRoutes.patientHome),
            ),
          ],
        ),
      ),
    );
  }
}
