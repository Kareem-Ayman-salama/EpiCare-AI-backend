import 'package:epicare_flutter/core/router/app_routes.dart';
import 'package:epicare_flutter/features/auth/presentation/screens/otp_screen.dart';
import 'package:epicare_flutter/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:epicare_flutter/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:epicare_flutter/features/medications/presentation/screens/medication_details_screen.dart';
import 'package:epicare_flutter/features/medications/presentation/screens/medication_log_screen.dart';
import 'package:epicare_flutter/features/medications/presentation/screens/medications_screen.dart';
import 'package:epicare_flutter/features/onboarding/presentation/screens/onboarding_flow_screen.dart';
import 'package:epicare_flutter/features/patient_home/presentation/screens/patient_home_screen.dart';
import 'package:epicare_flutter/features/patient_shell/presentation/screens/patient_shell_screen.dart';
import 'package:epicare_flutter/features/profile/presentation/screens/caregiver_screen.dart';
import 'package:epicare_flutter/features/profile/presentation/screens/device_screen.dart';
import 'package:epicare_flutter/features/profile/presentation/screens/doctor_screen.dart';
import 'package:epicare_flutter/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:epicare_flutter/features/profile/presentation/screens/help_support_screen.dart';
import 'package:epicare_flutter/features/profile/presentation/screens/notification_settings_screen.dart';
import 'package:epicare_flutter/features/seizure_log/presentation/screens/seizure_details_screen.dart';
import 'package:epicare_flutter/features/seizure_log/presentation/screens/seizure_log_screen.dart';
import 'package:epicare_flutter/features/seizure_prediction/presentation/screens/seizure_prediction_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.onboarding,
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingFlowScreen(),
      ),
      GoRoute(
        path: AppRoutes.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutes.otp,
        builder: (context, state) => const OtpScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return PatientShellScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.patientHome,
                builder: (context, state) => const PatientHomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.medications,
                builder: (context, state) => const MedicationsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.seizureLog,
                builder: (context, state) => const SeizureLogScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const EditProfileScreen(isProfileHub: true),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.medicationDetails,
        builder: (context, state) => const MedicationDetailsScreen(),
      ),
      GoRoute(
        path: AppRoutes.medicationLog,
        builder: (context, state) => const MedicationLogScreen(),
      ),
      GoRoute(
        path: AppRoutes.seizureDetails,
        builder: (context, state) => const SeizureDetailsScreen(),
      ),
      GoRoute(
        path: AppRoutes.editProfile,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.caregiver,
        builder: (context, state) => const CaregiverScreen(),
      ),
      GoRoute(
        path: AppRoutes.doctor,
        builder: (context, state) => const DoctorScreen(),
      ),
      GoRoute(
        path: AppRoutes.device,
        builder: (context, state) => const DeviceScreen(),
      ),
      GoRoute(
        path: AppRoutes.notificationSettings,
        builder: (context, state) => const NotificationSettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.helpSupport,
        builder: (context, state) => const HelpSupportScreen(),
      ),
      GoRoute(
        path: AppRoutes.seizurePrediction,
        builder: (context, state) => const SeizurePredictionScreen(),
      ),
    ],
  );
});
