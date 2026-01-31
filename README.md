# template_app

Flutter template: feature-first MVC, GetX, optional dark mode and Firebase Crashlytics.

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
| [logger](https://pub.dev/packages/logger)                                                                                       | Structured logging → [LoggerService](lib/shared/services/logger_service.dart)                                                             |
| [get_storage](https://pub.dev/packages/get_storage)                                                                             | Lightweight storage (optional)                                                                                                             |
| [firebase_core](https://pub.dev/packages/firebase_core) / [firebase_crashlytics](https://pub.dev/packages/firebase_crashlytics) | Optional crash reporting → [CrashReporter](lib/shared/services/crash_reporter.dart)                                                        |

## Project structure

```
lib/
├── app/         # Routes, theme, pages
├── core/        # Config, constants, extensions, shared widgets
├── features/    # MVC per feature (controller, model, view)
├── shared/      # ApiService, PrefsService, CrashReporter, LoggerService, UrlLauncherService
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

**Logger**

```dart
final log = Get.find<LoggerService>();
log.debug('User opened screen');
log.info('Data loaded', {'count': items.length});
log.warning('Retrying request');
log.error('Request failed', e, st);
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

- **API base URL:** `kApiBaseUrl` in `app_config.dart`; override: `flutter run --dart-define=API_BASE_URL=https://...`
- **Crashlytics:** Set `kUseFirebaseCrashlytics = true`, add `google-services.json` / `GoogleService-Info.plist`, then build.

## Checklist (new app)

- [ ] Set app name and bundle IDs; set `kApiBaseUrl`
- [ ] Enable Crashlytics if needed; replace template features with real flows
- [ ] Add assets in `pubspec.yaml` if needed; run `flutter analyze`
