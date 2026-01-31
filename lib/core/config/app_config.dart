/// App feature flags and optional integrations.
/// Set [kUseFirebaseCrashlytics] to true and add Firebase config files to enable Crashlytics.
const bool kUseFirebaseCrashlytics = false;

/// App version (name+build). Keep in sync with `version:` in pubspec.yaml, or pass at build:
/// `flutter run --dart-define=APP_VERSION=1.0.0+1`
const String kAppVersion = String.fromEnvironment(
  'APP_VERSION',
  defaultValue: '1.0.0+1',
);

/// Current environment name (e.g. dev, staging, prod).
/// Override: `flutter run --dart-define=ENVIRONMENT=staging`
const String kEnvironment = String.fromEnvironment(
  'ENVIRONMENT',
  defaultValue: 'development',
);

/// Base URL for API requests. Override via env or flavors (e.g. dev/staging/prod).
const String kApiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'https://api.example.com',
);

/// Optional: WebSocket or realtime API base URL.
const String kWsBaseUrl = String.fromEnvironment(
  'WS_BASE_URL',
  defaultValue: '',
);

/// Optional: API key for external services. Prefer secure storage in production.
const String kApiKey = String.fromEnvironment(
  'API_KEY',
  defaultValue: '',
);

/// Optional: enable verbose logging in this environment.
const bool kVerboseLogging = bool.fromEnvironment(
  'VERBOSE_LOGGING',
  defaultValue: false,
);
