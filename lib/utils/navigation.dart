import 'package:flutter/material.dart';

import '../widgets.dart';

class Navigation {
  static final navigator = new GlobalKey<NavigatorState>();
  static final bottomNav = GlobalKey<BottomNavigationState>();

  static get currentContext => navigator.currentContext;

  static jumpToPage(int page) {
    bottomNav.currentState.jumpToPage(page);
  }

  @optionalTypeArgs
  static Future<T> pushNamed<T extends Object>(
    String routeName, {
    Object arguments,
  }) {
    return navigator.currentState.pushNamed<T>(routeName, arguments: arguments);
  }

  static Future<void> pushNamedAndRemoveUntil(
    String newRouteName,
    RoutePredicate predicate, {
    Object arguments,
  }) {
    return navigator.currentState
        .pushNamedAndRemoveUntil(newRouteName, predicate, arguments: arguments);
  }

  @optionalTypeArgs
  static void pop<T extends Object>([T result]) {
    navigator.currentState.pop(result);
  }

  static void popUntil(RoutePredicate predicate) {
    navigator.currentState.popUntil(predicate);
  }
}