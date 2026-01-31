import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Centralized logging via [logger] package. Use [Get.find<LoggerService>()] or pass the instance.
/// In release, only messages at [releaseLevel] or above are shown (default [Level.warning]).
class LoggerService {
  LoggerService({
    Level releaseLevel = Level.warning,
    LogOutput? output,
  })  : _releaseLevel = releaseLevel,
        _logger = Logger(
          output: output ?? _DebugPrintOutput(),
          printer: PrettyPrinter(
            methodCount: 2,
            errorMethodCount: 8,
            lineLength: 80,
            colors: true,
            printEmojis: true,
            dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
          ),
          level: kReleaseMode ? releaseLevel : Level.trace,
        );

  final Level _releaseLevel;
  final Logger _logger;

  Level get releaseLevel => _releaseLevel;

  void trace(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.t(message, error: error, stackTrace: stackTrace);
  }

  void debug(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  void info(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  void warning(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  void fatal(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }
}

/// [LogOutput] that forwards each line to [debugPrint].
class _DebugPrintOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    for (final line in event.lines) {
      debugPrint(line);
    }
  }
}
