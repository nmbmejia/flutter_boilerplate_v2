import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template_app/app/app_pages.dart';
import 'package:template_app/app/routes.dart';
import 'package:template_app/app/theme/app_theme.dart';
import 'package:template_app/app/theme/theme_controller.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    ErrorWidget.builder =
        (FlutterErrorDetails details) => _PrettyErrorWidget(details: details);

    return Obx(() {
      final themeMode = Get.find<ThemeController>().themeMode;
      return GetMaterialApp(
        title: 'Boilerplate App',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeMode,
        initialRoute: Routes.home,
        getPages: AppPages.routes,
      );
    });
  }
}

/// Replaces the default red error screen with a themed, readable message.
class _PrettyErrorWidget extends StatelessWidget {
  const _PrettyErrorWidget({required this.details});

  final FlutterErrorDetails details;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Something went wrong',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'We\'re sorry for the inconvenience. Please try again or restart the app.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  if (kDebugMode) ...[
                    const SizedBox(height: 24),
                    _DebugErrorDetails(details: details),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Expandable debug section showing exception and stack (only in debug mode).
class _DebugErrorDetails extends StatefulWidget {
  const _DebugErrorDetails({required this.details});

  final FlutterErrorDetails details;

  @override
  State<_DebugErrorDetails> createState() => _DebugErrorDetailsState();
}

class _DebugErrorDetailsState extends State<_DebugErrorDetails> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final exception = widget.details.exceptionAsString();
    final stack = widget.details.stack?.toString() ?? 'No stack trace';

    final errorContainer = theme.colorScheme.errorContainer;
    final outlineColor = theme.colorScheme.outline;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromRGBO(
          errorContainer.red,
          errorContainer.green,
          errorContainer.blue,
          0.3,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color.fromRGBO(
            outlineColor.red,
            outlineColor.green,
            outlineColor.blue,
            0.5,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => setState(() => _expanded = !_expanded),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      _expanded ? Icons.expand_less : Icons.expand_more,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _expanded ? 'Hide details' : 'Show details (debug)',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_expanded) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SelectableText(
                '$exception\n\n$stack',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
