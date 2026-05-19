class AppRoutes {
  const AppRoutes._();

  static const onboarding = '/';
  static const signIn = '/auth/sign-in';
  static const signUp = '/auth/sign-up';
  static const otp = '/auth/otp';

  static const patientHome = '/patient/home';
  static const medications = '/patient/medications';
  static const medicationDetails = '/patient/medications/details';
  static const medicationLog = '/patient/medications/log';
  static const seizureLog = '/patient/seizures';
  static const seizureDetails = '/patient/seizures/details';
  static const profile = '/patient/profile';

  static const editProfile = '/patient/profile/edit';
  static const caregiver = '/patient/profile/caregiver';
  static const doctor = '/patient/profile/doctor';
  static const device = '/patient/profile/device';
  static const notificationSettings = '/patient/profile/notifications';
  static const helpSupport = '/patient/profile/help';

  static const seizurePrediction = '/patient/prediction';
}
