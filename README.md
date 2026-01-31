# template_app

A Flutter template with feature-first MVC, GetX, optional dark mode, optional Firebase Crashlytics, and shared API/error handling.

## Getting Started

- Run `flutter pub get` and `flutter run`.
- See [Flutter documentation](https://docs.flutter.dev/) for general Flutter development.

## Project Structure

```
lib/
├── app/              # App shell: routes, theme, pages list
├── core/             # Config, constants, extensions, shared widgets, validators
├── features/         # Feature modules (auth, home, …), each with controller / model / view
├── shared/           # Cross-feature services (ApiService, CrashReporter)
└── main.dart
```

- **Features** follow MVC: `controller/`, `model/`, `view/`. Each feature has a `*_feature.dart` barrel and a GetX binding used in `app_pages.dart`.
- **Navigation**: Use `Routes.*` and `Get.toNamed(Routes.xyz)` (no raw route strings).
- **API**: `Get.find<ApiService>()` (or inject in bindings). Base URL is set in `lib/core/config/app_config.dart` via `kApiBaseUrl` (defaults to `https://api.example.com`; override with `--dart-define=API_BASE_URL=...` or flavors).
- **Prefs & URL launcher**: `Get.find<PrefsService>()` and `Get.find<UrlLauncherService>()`; link widgets in `lib/core/widgets/link_button.dart` (see [Shared services & widgets](#shared-services--widgets)).

## Adding a New Feature

1. Create `lib/features/<name>/` with:
   - `controller/<name>_controller.dart` (extends `GetxController`), `controller/<name>_binding.dart`
   - `model/<name>_model.dart` (e.g. immutable data + `copyWith`)
   - `view/<name>_page.dart` (extends `GetView<YourController>`)
   - `<name>_feature.dart` that exports the public parts
2. Add route in `lib/app/routes.dart` and a `GetPage` in `lib/app/app_pages.dart` with the binding.
3. Navigate with `Get.toNamed(Routes.yourRoute)`.

## Shared services & widgets

### PrefsService (shared_preferences)

Key-value storage backed by platform prefs. Registered in `main.dart` via `Get.put(await PrefsService.init())`.

- **Get/set with defaults:** `getString(key)`, `getStringOr(key, default)`, `setString(key, value)`; same for `bool`, `int`, `double`, `StringList`.
- **Other:** `containsKey(key)`, `remove(key)`, `clear()`, `keys`.

```dart
final prefs = Get.find<PrefsService>();
await prefs.setString('token', token);
final theme = prefs.getStringOr('theme', 'light');
```

### UrlLauncherService (url_launcher)

Opens URLs, mail, and phone. Registered in `main.dart` via `Get.put(UrlLauncherService())`.

- **`launchUrl(url, {mode})`** / **`launchUri(uri, {mode})`** — Launch a URL; returns `true`/`false`; logs failure in debug.
- **`openInBrowser(url)`** — Open in external browser.
- **`launchMailto(email, {subject, body})`** — Open mail client.
- **`launchTel(phoneNumber)`** — Open dialer.

```dart
final launcher = Get.find<UrlLauncherService>();
await launcher.openInBrowser('https://example.com');
await launcher.launchMailto('support@example.com', subject: 'Help');
await launcher.launchTel('+1 234 567 8900');
```

### LinkButton & LinkText (core/widgets/link_button.dart)

- **`LinkButton`** — Wraps any `child`; on tap launches `url` (uses `UrlLauncherService` when registered). Optional `onOpened` / `onFailed`, `mode` (e.g. external browser).
- **`LinkText`** — Text styled as a link that launches `url` on tap.

```dart
LinkButton(
  url: 'https://example.com',
  child: Row(children: [Icon(Icons.open_in_new), Text('Open')]),
  onFailed: () => Get.snackbar('Error', 'Could not open link'),
)

LinkText('Privacy Policy', url: 'https://example.com/privacy')
```

## Optional: API Base URL

- Default: `kApiBaseUrl` in `lib/core/config/app_config.dart` is `https://api.example.com`.
- Override at build time:  
  `flutter run --dart-define=API_BASE_URL=https://staging.example.com`  
  or in release:  
  `flutter build apk --dart-define=API_BASE_URL=https://api.myapp.com`

## Optional: Firebase Crashlytics

Crashlytics is **off by default**. The app runs without any Firebase config.

To enable:

1. **Turn on the flag**  
   In `lib/core/config/app_config.dart`, set:

   ```dart
   const bool kUseFirebaseCrashlytics = true;
   ```

2. **Add Firebase to your project**
   - Create a project in [Firebase Console](https://console.firebase.google.com/) and add Android/iOS apps.
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) and place them in:
     - Android: `android/app/`
     - iOS: `ios/Runner/`
   - Or run `dart run flutterfire configure` (requires [FlutterFire CLI](https://firebase.google.com/docs/flutter/setup)) to generate config files.

3. **Build and run**  
   With the flag set to `true` and config files in place, crashes and non-fatal errors are reported to Crashlytics.

Use `CrashReporter.log('message')`, `CrashReporter.recordError(...)`, and `CrashReporter.setUserId(...)` from `lib/shared/services/crash_reporter.dart`; they no-op when Crashlytics is disabled.

## Template Checklist (when cloning for a new app)

- [ ] Set app name and bundle IDs in Android/iOS (and `pubspec.yaml` name/description).
- [ ] Set `kApiBaseUrl` (or dart-define/flavors) for your API.
- [ ] Enable Crashlytics if needed (`kUseFirebaseCrashlytics` + Firebase config).
- [ ] Replace or remove template features (e.g. home counter, auth placeholder) with real flows.
- [ ] Add assets/fonts in `pubspec.yaml` if needed; add `.env.example` and document env vars if you use them.
- [ ] Run `flutter analyze` and fix any new lints; add tests for new features.
