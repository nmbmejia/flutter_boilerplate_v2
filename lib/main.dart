import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template_app/app/app.dart';
import 'package:template_app/app/theme/theme_controller.dart';
import 'package:template_app/core/config/app_config.dart';
import 'package:template_app/shared/services/api_service.dart';
import 'package:template_app/shared/services/crash_reporter.dart';
import 'package:template_app/shared/services/prefs_service.dart';
import 'package:template_app/shared/services/logger_service.dart';
import 'package:template_app/shared/services/url_launcher_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(ThemeController());
  Get.put(ApiService());
  Get.put(await PrefsService.init());
  Get.put(UrlLauncherService());
  Get.put(LoggerService());

  if (kUseFirebaseCrashlytics) {
    await Firebase.initializeApp();
    await CrashReporter.init();
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    };
    runZonedGuarded<void>(() {
      runApp(const App());
    }, (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    });
  } else {
    runApp(const App());
  }
}
