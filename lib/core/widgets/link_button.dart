import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template_app/shared/services/url_launcher_service.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

/// Button that launches a URL when tapped.
/// Uses [UrlLauncherService] when registered; otherwise falls back to [launcher.launchUrl].
class LinkButton extends StatelessWidget {
  const LinkButton({
    super.key,
    required this.url,
    required this.child,
    this.mode = launcher.LaunchMode.platformDefault,
    this.onOpened,
    this.onFailed,
  });

  final String url;
  final Widget child;
  final launcher.LaunchMode mode;
  final VoidCallback? onOpened;
  final VoidCallback? onFailed;

  Future<void> _launch(BuildContext context) async {
    final service = Get.isRegistered<UrlLauncherService>()
        ? Get.find<UrlLauncherService>()
        : null;
    final ok = service != null
        ? await service.launchUrl(url, mode: mode)
        : await _launchFallback();
    if (context.mounted) {
      if (ok) {
        onOpened?.call();
      } else {
        onFailed?.call();
      }
    }
  }

  Future<bool> _launchFallback() async {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    try {
      if (await launcher.canLaunchUrl(uri)) {
        return await launcher.launchUrl(uri, mode: mode);
      }
    } catch (_) {}
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _launch(context),
      child: child,
    );
  }
}

/// Text that looks like a link and launches [url] when tapped.
class LinkText extends StatelessWidget {
  const LinkText(
    this.text, {
    super.key,
    required this.url,
    this.style,
    this.mode = launcher.LaunchMode.platformDefault,
    this.onOpened,
    this.onFailed,
  });

  final String text;
  final String url;
  final TextStyle? style;
  final launcher.LaunchMode mode;
  final VoidCallback? onOpened;
  final VoidCallback? onFailed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final linkStyle = style ??
        theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.primary,
          decoration: TextDecoration.underline,
          decorationColor: theme.colorScheme.primary,
        );
    return LinkButton(
      url: url,
      mode: mode,
      onOpened: onOpened,
      onFailed: onFailed,
      child: Text(text, style: linkStyle),
    );
  }
}
