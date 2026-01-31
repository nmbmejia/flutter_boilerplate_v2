/// App feature flags and optional integrations.
/// Set [kUseFirebaseCrashlytics] to true and add Firebase config files to enable Crashlytics.
const bool kUseFirebaseCrashlytics = false;

/// Base URL for API requests. Override via env or flavors (e.g. dev/staging/prod).
const String kApiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'https://api.example.com',
);
