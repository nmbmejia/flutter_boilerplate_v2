import 'package:flutter/material.dart';
import 'package:template_app/app/theme/app_colors.dart';

/// App theme configuration. Uses withValues (not deprecated withOpacity).
abstract class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          onPrimary: AppColors.onPrimary,
          primaryContainer: AppColors.primaryContainer,
          onPrimaryContainer: AppColors.onPrimaryContainer,
          secondary: AppColors.secondary,
          secondaryContainer: AppColors.secondaryContainer,
          surface: AppColors.surface,
          onSurface: AppColors.onSurface,
          surfaceContainerLowest: AppColors.surfaceContainerLowest,
          outline: AppColors.outline,
          error: AppColors.error,
          onError: AppColors.onError,
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: AppColorsDark.primary,
          onPrimary: AppColorsDark.onPrimary,
          primaryContainer: AppColorsDark.primaryContainer,
          onPrimaryContainer: AppColorsDark.onPrimaryContainer,
          secondary: AppColorsDark.secondary,
          secondaryContainer: AppColorsDark.secondaryContainer,
          surface: AppColorsDark.surface,
          onSurface: AppColorsDark.onSurface,
          surfaceContainerLowest: AppColorsDark.surfaceContainerLowest,
          outline: AppColorsDark.outline,
          error: AppColorsDark.error,
          onError: AppColorsDark.onError,
        ),
      );
}
