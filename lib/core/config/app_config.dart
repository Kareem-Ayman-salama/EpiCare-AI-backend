class AppConfig {
  const AppConfig._();

  static const apiBaseUrl = String.fromEnvironment(
    'EPICARE_API_BASE_URL',
    defaultValue: 'http://localhost:8080',
  );
  static const seizureWarningLeadTime = Duration(minutes: 30);
}
