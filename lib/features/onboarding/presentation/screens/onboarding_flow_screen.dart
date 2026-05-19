import 'package:epicare_flutter/core/router/app_routes.dart';
import 'package:epicare_flutter/core/theme/app_colors.dart';
import 'package:epicare_flutter/shared/widgets/app_button.dart';
import 'package:epicare_flutter/shared/widgets/app_card.dart';
import 'package:epicare_flutter/shared/widgets/epicare_logo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingFlowScreen extends StatefulWidget {
  const OnboardingFlowScreen({super.key});

  @override
  State<OnboardingFlowScreen> createState() => _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends State<OnboardingFlowScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_page == 4) {
      context.go(AppRoutes.signUp);
      return;
    }

    _controller.nextPage(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (value) => setState(() => _page = value),
                  children: const [
                    _SplashPage(),
                    _IntroPage(),
                    _RolePage(),
                    _FeaturePage(
                      icon: Icons.warning_amber_rounded,
                      title: 'Instant Seizure Alerts',
                      subtitle: 'Glow, vibration, and phone alarms warn patient and caregiver early.',
                    ),
                    _FeaturePage(
                      icon: Icons.family_restroom_rounded,
                      title: 'Stay Connected',
                      subtitle: 'Caregivers and doctors can securely review seizure logs and progress.',
                    ),
                  ],
                ),
              ),
              if (_page != 2) ...[
                _PagerDots(activeIndex: _page, count: 5),
                const SizedBox(height: 24),
                AppButton(
                  label: _page == 4 ? 'Get started' : 'Continue',
                  onPressed: _next,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SplashPage extends StatelessWidget {
  const _SplashPage();

  @override
  Widget build(BuildContext context) {
    return const Center(child: EpiCareLogo(width: 320, textSize: 52));
  }
}

class _IntroPage extends StatelessWidget {
  const _IntroPage();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 28),
        EpiCareLogo(width: 260, textSize: 42),
        Spacer(),
        Icon(Icons.watch_rounded, color: AppColors.primary, size: 150),
        SizedBox(height: 28),
        Text(
          'The Future of Seizure Safety',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 31, fontWeight: FontWeight.w900, color: AppColors.ink),
        ),
        SizedBox(height: 20),
        Text(
          'AI-powered support for patients, caregivers, and doctors helping everyone respond faster and care better.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, height: 1.45, color: AppColors.ink),
        ),
        Spacer(),
      ],
    );
  }
}

class _RolePage extends StatelessWidget {
  const _RolePage();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 56),
        const Text(
          'Who Are You?',
          style: TextStyle(fontSize: 42, fontWeight: FontWeight.w900, color: AppColors.ink),
        ),
        const SizedBox(height: 18),
        const Text(
          'Select a role to personalize your EpiCare experience.',
          style: TextStyle(fontSize: 20, height: 1.35, color: AppColors.ink),
        ),
        const Spacer(),
        _RoleCard(
          icon: Icons.health_and_safety_outlined,
          title: 'Patient',
          subtitle: 'I want to monitor my seizures',
          onTap: () {},
        ),
        const SizedBox(height: 16),
        _RoleCard(
          icon: Icons.medical_services_outlined,
          title: 'Doctor',
          subtitle: 'I manage treatment and patient records',
          onTap: () {},
        ),
        const SizedBox(height: 16),
        _RoleCard(
          icon: Icons.groups_rounded,
          title: 'Caregiver',
          subtitle: 'I care for someone with epilepsy',
          onTap: () {},
        ),
        const Spacer(),
        AppButton(
          label: 'Continue as patient',
          onPressed: () => context.go(AppRoutes.signUp),
        ),
      ],
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [AppColors.primaryLight, AppColors.primary]),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 34),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.3),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class _FeaturePage extends StatelessWidget {
  const _FeaturePage({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 42),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => context.go(AppRoutes.signUp),
            child: const Text('Skip'),
          ),
        ),
        const Spacer(),
        AppCard(
          padding: const EdgeInsets.all(34),
          child: Icon(icon, color: AppColors.primary, size: 150),
        ),
        const SizedBox(height: 52),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 14),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.ink, fontSize: 17, height: 1.45),
        ),
        const Spacer(),
      ],
    );
  }
}

class _PagerDots extends StatelessWidget {
  const _PagerDots({required this.activeIndex, required this.count});

  final int activeIndex;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: index == activeIndex ? 42 : 16,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: index == activeIndex ? AppColors.primary : AppColors.line,
            borderRadius: BorderRadius.circular(99),
          ),
        );
      }),
    );
  }
}
