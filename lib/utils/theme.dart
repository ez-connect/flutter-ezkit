import 'package:flutter/material.dart';

import 'navigation.dart';

class ThemeEx {
  static ThemeData get theme {
    return Theme.of(Navigation.currentContext);
  }

  static TextTheme get text {
    return Theme.of(Navigation.currentContext).textTheme;
  }

  static Size get size {
    return MediaQuery.of(Navigation.currentContext).size;
  }

  static Color hex2Color(String value) {
    if (value == null) return null;

    value = value.toUpperCase().replaceAll("#", "");
    if (value.length == 6) {
      value = "FF" + value;
    }

    try {
      final color = int.parse(value, radix: 16);
      return Color(color);
    } catch (err) {
      return null;
    }
  }
}
