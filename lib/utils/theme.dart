import 'package:flutter/material.dart';

import '../routing/navigation.dart';

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

  static int getColorFromHex(String value) {
    value = value.toUpperCase().replaceAll("#", "");
    if (value.length == 6) {
      value = "FF" + value;
    }
    return int.parse(value, radix: 16);
  }
}
