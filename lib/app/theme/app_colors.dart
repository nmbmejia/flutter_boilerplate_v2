import 'package:flutter/material.dart';

/// Centralized app color palette (light).
abstract class AppColors {
  static const Color primary = Color(0xFF6750A4);
  static const Color primaryContainer = Color(0xFFEADDFF);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF21005D);
  static const Color secondary = Color(0xFF625B71);
  static const Color secondaryContainer = Color(0xFFE8DEF8);
  static const Color surface = Color(0xFFFFFBFE);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF1C1B1F);
  static const Color outline = Color(0xFF79747E);
  static const Color error = Color(0xFFB3261E);
  static const Color onError = Color(0xFFFFFFFF);
}

/// Dark theme color palette.
abstract class AppColorsDark {
  static const Color primary = Color(0xFFD0BCFF);
  static const Color primaryContainer = Color(0xFF4F378B);
  static const Color onPrimary = Color(0xFF381E72);
  static const Color onPrimaryContainer = Color(0xFFEADDFF);
  static const Color secondary = Color(0xFFCCC2DC);
  static const Color secondaryContainer = Color(0xFF4A4458);
  static const Color surface = Color(0xFF1C1B1F);
  static const Color surfaceContainerLowest = Color(0xFF1C1B1F);
  static const Color onSurface = Color(0xFFE6E1E5);
  static const Color outline = Color(0xFF938F99);
  static const Color error = Color(0xFFF2B8B5);
  static const Color onError = Color(0xFF601410);
}
