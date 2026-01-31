import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:template_app/core/config/app_config.dart';

/// Optional crash reporting. When [kUseFirebaseCrashlytics] is true, delegates to Firebase Crashlytics.
/// When false, all methods no-op so the app runs without initializing Firebase.
class CrashReporter {
  CrashReporter._();

  static bool get _enabled => kUseFirebaseCrashlytics;

  /// Call once after [WidgetsBinding.ensureInitialized]. No-op when Crashlytics is disabled.
  static Future<void> init() async {
    if (!_enabled) return;
    try {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } catch (e, st) {
      debugPrint('CrashReporter init failed: $e');
      debugPrint(st.toString());
    }
  }

  /// Log a message (breadcrumb). No-op when disabled.
  static void log(String message) {
    if (!_enabled) return;
    FirebaseCrashlytics.instance.log(message);
  }

  /// Record a non-fatal error. No-op when disabled.
  static Future<void> recordError(
    Object exception,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
  }) async {
    if (!_enabled) return;
    await FirebaseCrashlytics.instance.recordError(
      exception,
      stackTrace,
      reason: reason,
      fatal: fatal,
    );
  }

  /// Set user identifier for crash reports. No-op when disabled.
  static void setUserId(String? userId) {
    if (!_enabled) return;
    FirebaseCrashlytics.instance.setUserIdentifier(userId ?? '');
  }
}
