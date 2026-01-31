import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// App-level theme mode (light / dark / system). Optional dark mode support.
class ThemeController extends GetxController {
  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;

  ThemeMode get themeMode => _themeMode.value;
  bool get isDark => _themeMode.value == ThemeMode.dark;
  bool get isLight => _themeMode.value == ThemeMode.light;
  bool get isSystem => _themeMode.value == ThemeMode.system;

  void setThemeMode(ThemeMode mode) {
    _themeMode(mode);
  }

  void setLight() => setThemeMode(ThemeMode.light);
  void setDark() => setThemeMode(ThemeMode.dark);
  void setSystem() => setThemeMode(ThemeMode.system);

  void toggleBetweenLightAndDark() {
    _themeMode(_themeMode.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  }
}
