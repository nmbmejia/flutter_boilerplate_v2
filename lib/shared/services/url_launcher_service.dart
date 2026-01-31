import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

/// Wrapper around [url_launcher] for easier use with error handling and common schemes.
/// Use [Get.find<UrlLauncherService>()] or pass the instance.
class UrlLauncherService {
  UrlLauncherService();

  /// Launch a URL. Returns true if launched, false otherwise. Logs failure in debug.
  Future<bool> launchUrl(
    String url, {
    launcher.LaunchMode mode = launcher.LaunchMode.platformDefault,
  }) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      if (kDebugMode) debugPrint('UrlLauncherService: invalid URL "$url"');
      return false;
    }
    return launchUri(uri, mode: mode);
  }

  /// Launch a [Uri]. Returns true if launched, false otherwise.
  Future<bool> launchUri(
    Uri uri, {
    launcher.LaunchMode mode = launcher.LaunchMode.platformDefault,
  }) async {
    try {
      if (await launcher.canLaunchUrl(uri)) {
        return await launcher.launchUrl(uri, mode: mode);
      }
      if (kDebugMode) debugPrint('UrlLauncherService: cannot launch $uri');
      return false;
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('UrlLauncherService: $e');
        debugPrint(st.toString());
      }
      return false;
    }
  }

  /// Open [url] in external browser (e.g. Chrome/Safari).
  Future<bool> openInBrowser(String url) =>
      launchUrl(url, mode: launcher.LaunchMode.externalApplication);

  /// Open mail client with [email] as recipient. [subject] and [body] are optional.
  Future<bool> launchMailto(
    String email, {
    String? subject,
    String? body,
  }) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      query: _encodeQuery({'subject': subject, 'body': body}),
    );
    return launchUri(uri);
  }

  /// Open phone dialer with [phoneNumber] (digits only or with +, spaces, dashes).
  Future<bool> launchTel(String phoneNumber) async {
    final cleaned = phoneNumber.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    final uri = Uri(scheme: 'tel', path: cleaned);
    return launchUri(uri);
  }

  static String? _encodeQuery(Map<String, String?> query) {
    final pairs = <String>[];
    query.forEach((key, value) {
      if (value != null && value.isNotEmpty) {
        pairs.add('$key=${Uri.encodeComponent(value)}');
      }
    });
    return pairs.isEmpty ? null : pairs.join('&');
  }
}
