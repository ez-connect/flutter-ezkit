import 'package:flutter/material.dart';

import 'package:ezkit/ezkit.dart';

import 'constants/index.dart';
import 'screens/index.dart';

final Map<DynamicRoute, Widget Function(dynamic)> routesMapping = {
  DynamicRoute(kRouteHome): (arguments) {
    return MainScreen();
  },
};
