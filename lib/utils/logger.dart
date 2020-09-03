// Use ANSI escape code
// https://en.wikipedia.org/wiki/ANSI_escape_code#3/4_bit
import 'package:flutter/foundation.dart';

class Logger {
  static bool enabled = kDebugMode;

  static void debug(Object object) {
    if (enabled) {
      print('\x1b[90m ${object.toString()}');
    }
  }

  static void info(Object object) {
    if (enabled) {
      print('\x1b[35m ${object.toString()}');
    }
  }

  static void warn(Object object) {
    if (enabled) {
      print('\x1b[33m ${object.toString()}');
    }
  }

  static void error(Object object) {
    if (enabled) {
      print('\x1b[31m ${object.toString()}');
    }
  }
}
