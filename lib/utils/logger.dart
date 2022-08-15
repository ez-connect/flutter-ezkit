// Use ANSI escape code
// https://en.wikipedia.org/wiki/ANSI_escape_code#3/4_bit
import 'package:flutter/foundation.dart';

class Logger {
  /// Enable logging, default is true in debug mode
  static bool enabled = kDebugMode;

  /// Enable warning & error, default is true.
  /// Set it to false to disable in release mode.
  static bool enabledWarn = true;

  static void debug(Object object) {
    if (enabled) {
      print('\x1b[90m ${object.toString()}');
    }
  }

  static void info(Object? object) {
    if (enabled) {
      print('\x1b[35m ${object.toString()}');
    }
  }

  static void warn(Object object) {
    if (enabled || enabledWarn) {
      print('\x1b[33m ${object.toString()}');
    }
  }

  static void error(Object object) {
    if (enabled || enabledWarn) {
      print('\x1b[31m ${object.toString()}');
    }
  }
}
