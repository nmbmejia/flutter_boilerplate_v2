# Flutter Template App V2

## Features

- **Feature-first MVC** — Controllers, models, and views organized per feature under `lib/features/`.
- **GetX** — State management, routing, and dependency injection (Obx, bindings, Get.find).
- **Premade dark mode** — Optional dark theme wired and ready to use.
- **API layer** — Dio-based [ApiService](lib/shared/services/api_service.dart) with configurable base URL.
- **Local storage** — [PrefsService](lib/shared/services/prefs_service.dart) (shared_preferences) and optional get_storage.
- **URL launcher** — Open links, mail, and phone via [UrlLauncherService](lib/shared/services/url_launcher_service.dart) and [LinkButton](lib/core/widgets/link_button.dart).
- **Cached images** — [CachedNetworkImageWidget](lib/core/widgets/cached_network_image_widget.dart) for network images.
- **Optional Crashlytics** — [CrashReporter](lib/shared/services/crash_reporter.dart) (Firebase Crashlytics, off by default).
- **App config** — Central config in `app_config.dart` (env, API URL, version, feature flags).

## Getting Started

**Prerequisites:** Dart `^3.5.3`, Flutter `3.24.3` ([install](https://docs.flutter.dev/get-started/install)).

```bash
flutter pub get && flutter run
```

## Dependencies

| Package                                                                                                                         | Why                                                                                                                                        |
| ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| [get](https://pub.dev/packages/get)                                                                                             | State, routing, DI (Obx, bindings, Get.find)                                                                                               |
| [dio](https://pub.dev/packages/dio)                                                                                             | HTTP client → [ApiService](lib/shared/services/api_service.dart)                                                                           |
| [cached_network_image](https://pub.dev/packages/cached_network_image)                                                           | Cached images → [CachedNetworkImageWidget](lib/core/widgets/cached_network_image_widget.dart)                                              |
| [shared_preferences](https://pub.dev/packages/shared_preferences)                                                               | Key-value storage → [PrefsService](lib/shared/services/prefs_service.dart)                                                                 |
| [url_launcher](https://pub.dev/packages/url_launcher)                                                                           | Open links/mail/tel → [UrlLauncherService](lib/shared/services/url_launcher_service.dart), [LinkButton](lib/core/widgets/link_button.dart) |
| [intl](https://pub.dev/packages/intl)                                                                                           | Internationalization: dates, numbers, plurals, message formatting                                                                          |
| [get_storage](https://pub.dev/packages/get_storage)                                                                             | Lightweight storage (optional)                                                                                                             |
| [firebase_core](https://pub.dev/packages/firebase_core) / [firebase_crashlytics](https://pub.dev/packages/firebase_crashlytics) | Optional crash reporting → [CrashReporter](lib/shared/services/crash_reporter.dart)                                                        |

## Project structure

```
lib/
├── app/         # Routes, theme, pages
├── core/        # Config, constants, extensions, shared widgets
├── features/    # MVC per feature (controller, model, view)
├── shared/      # ApiService, PrefsService, CrashReporter, UrlLauncherService
└── main.dart
```

## Usage examples

**Navigation**

```dart
Get.toNamed(Routes.login);
Get.back();
Get.offAllNamed(Routes.home);
```

**API** (base URL in `lib/core/config/app_config.dart`)

```dart
final api = Get.find<ApiService>();
final res = await api.get<Map<String, dynamic>>('/users/1');
await api.post('/login', data: {'email': email, 'password': password});
```

**Prefs**

```dart
final prefs = Get.find<PrefsService>();
await prefs.setString('token', token);
final token = prefs.getStringOr('token', '');
```

**Open URL / mail / phone**

```dart
final launcher = Get.find<UrlLauncherService>();
await launcher.openInBrowser('https://example.com');
await launcher.launchMailto('support@example.com', subject: 'Help');
await launcher.launchTel('+1234567890');
```

**Link widgets**

```dart
LinkText('Privacy Policy', url: 'https://example.com/privacy')

LinkButton(
  url: 'https://example.com',
  child: Text('Open'),
  onFailed: () => Get.snackbar('Error', 'Could not open link'),
)
```

**Cached network image**

```dart
CachedNetworkImageWidget(
  imageUrl: 'https://example.com/photo.jpg',
  width: 48,
  height: 48,
  borderRadius: BorderRadius.circular(24),
)
```

**Crash reporting** (off by default; set `kUseFirebaseCrashlytics = true` in `app_config.dart`)

```dart
CrashReporter.log('User tapped submit');
CrashReporter.recordError(e, st, fatal: false);
CrashReporter.setUserId(userId);
```

## Adding a feature

1. Create `lib/features/<name>/` with `controller/`, `model/`, `view/`, and `<name>_feature.dart`.
2. Add route in `routes.dart` and `GetPage` in `app_pages.dart` with binding.
3. Navigate with `Get.toNamed(Routes.<name>)`.

## Optional config

All values live in `lib/core/config/app_config.dart`. Override at build time with `--dart-define=NAME=value`.

- **App version:** `kAppVersion` (default matches `version:` in pubspec; keep in sync or pass `--dart-define=APP_VERSION=1.0.0+1`).
- **Environment:** `kEnvironment` (default `development`); e.g. `--dart-define=ENVIRONMENT=staging`
- **API base URL:** `kApiBaseUrl`; e.g. `--dart-define=API_BASE_URL=https://...`
- **WebSocket URL:** `kWsBaseUrl` (optional); e.g. `--dart-define=WS_BASE_URL=wss://...`
- **API key:** `kApiKey` (optional; prefer secure storage in production)
- **Verbose logging:** `kVerboseLogging` (optional); e.g. `--dart-define=VERBOSE_LOGGING=true`
- **Crashlytics:** Set `kUseFirebaseCrashlytics = true`, add `google-services.json` / `GoogleService-Info.plist`, then build.

## Checklist (new app)

<details>
<summary><strong>Identity & branding</strong></summary>

- [ ] Set app **name** in `pubspec.yaml` (`name:` and `description:`).
- [ ] Set **display name** per platform: Android `android/app/src/main/AndroidManifest.xml` (`android:label`), iOS `ios/Runner/Info.plist` (`CFBundleDisplayName`).
- [ ] Set **package / bundle ID**: Android `applicationId` in `android/app/build.gradle`, iOS `PRODUCT_BUNDLE_IDENTIFIER` in Xcode or `ios/Runner.xcodeproj/project.pbxproj`.
- [ ] Replace **app icon** (launcher): add assets and run `flutter pub run flutter_launcher_icons` or update `android/app/src/main/res/` and `ios/Runner/Assets.xcassets/AppIcon.appiconset/` manually.
- [ ] Replace **splash screen** if you use one (e.g. `flutter_native_splash` or platform-native assets).

</details>

<details>
<summary><strong>Config</strong> — <code>lib/core/config/app_config.dart</code></summary>

- [ ] Set **`kApiBaseUrl`** (and optionally `kWsBaseUrl`, `kApiKey`, `kEnvironment`) for your backend.
- [ ] Enable **Crashlytics** if needed: set `kUseFirebaseCrashlytics = true`, add `google-services.json` (Android) and `GoogleService-Info.plist` (iOS), then build.
- [ ] Remove or adjust any other feature flags / env vars you don’t need.

</details>

<details>
<summary><strong>Code & structure</strong></summary>

- [ ] Replace **template features** (e.g. home) with your real flows; add features under `lib/features/` with controller, model, view, and feature export.
- [ ] Update **routes**: `lib/app/routes.dart` and `lib/app/app_pages.dart` (GetPage list and bindings); set initial route in `lib/app/app.dart` if not home.
- [ ] Update **dependencies** in `pubspec.yaml`: remove unused packages (e.g. `get_storage`, Firebase) and add any new ones; run `flutter pub get`.

</details>

<details>
<summary><strong>Assets & quality</strong></summary>

- [ ] Declare **assets** in `pubspec.yaml` under `flutter: assets:` if you use images/fonts/etc.
- [ ] Run **`flutter analyze`** and fix any issues; run on a device or simulator to verify.

</details>

<details>
<summary><strong>Platform-specific</strong></summary>

- [ ] **Android:** Check `minSdkVersion` in `android/app/build.gradle`; add permissions in `AndroidManifest.xml` (e.g. internet, camera) and any required config (e.g. `usesCleartextTraffic` for dev).
- [ ] **iOS:** Set minimum iOS version in `ios/Podfile`; add permissions and URL schemes in `Info.plist` if needed (e.g. `LSApplicationQueriesSchemes` for url_launcher).
- [ ] **Signing:** Configure Android signing (keystore) and iOS provisioning for release builds.

</details>

<details>
<summary><strong>Release prep</strong></summary>

- [ ] Set **version** and **build number** in `pubspec.yaml` (`version: x.y.z+build`); bump for each store upload.
- [ ] Prepare **store listing** (screenshots, description, privacy policy URL) and ensure app complies with store policies.

</details>
