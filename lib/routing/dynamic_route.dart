import 'package:flutter/material.dart';

import '../utils.dart';

class DynamicRoute {
  static var _routesMapping = Map<DynamicRoute, Widget Function(dynamic)>();
  final String route;
  final _variable = Map<String, String>(); // <name, type>
  RegExp _regex;

  DynamicRoute(this.route) {
    var temp = this.route.replaceAll(RegExp(r'\/'), '\\/');
    temp = temp.replaceAllMapped(RegExp(r':([\w]+)(?:\(([\w]+)\)|)'), (match) {
      _variable.addAll({match.group(1): match.group(2) ?? 'string'});
      return '([\\d\\w]+)';
    });
    this._regex = RegExp('^$temp\$');
  }

  bool match(String route) {
    final uri = Uri.parse(route);
    return (uri.path == this.route || this._regex.hasMatch(uri.path));
  }

  Map<String, dynamic> _getArguments(String route) {
    final uri = Uri.parse(route);
    final args = Map<String, dynamic>();
    this._regex.allMatches(uri.path).forEach((element) {
      for (int i = 0; i < element.groupCount && i < _variable.length; i++) {
        dynamic value = element.group(i + 1);
        switch (_variable.values.elementAt(i)) {
          case 'int':
            value = int.tryParse(value);
            break;
          case 'double':
            value = double.tryParse(value);
            break;
          default: // default is string
            break;
        }
        args.addAll({_variable.keys.elementAt(i): value});
      }
    });

    // get all query params
    args.addAll(uri.queryParameters);
    print(args);
    return args;
  }

  RouteSettings getSetting(String route, Object args) {
    if (args != null && args is Map<String, dynamic> == false) {
      return RouteSettings(name: route, arguments: args);
    }

    // need rename
    final uri = Uri.parse(route);
    var name = uri.path;
    final arguments = Map<String, dynamic>()..addAll(args ?? {});
    if (name == this.route) {
      arguments.forEach((key, value) {
        name = name.replaceAll(RegExp(':$key(?:\\([\\w]+\\)|)'), '$value');
      });
    }
    arguments.addAll(_getArguments(route));
    return RouteSettings(name: name, arguments: arguments);
  }

  static init(Map<DynamicRoute, Widget Function(dynamic)> routesMapping) {
    _routesMapping = routesMapping;
  }

  static DynamicRoute findRoute(String route) {
    for (int i = 0; i < _routesMapping.keys.length; i++) {
      final key = _routesMapping.keys.elementAt(i);
      if (key.match(route)) {
        return key;
      }
    }
    return null;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    Logger.info('Generate route: ${settings.name}');
    final arguments = settings.arguments;
    final route = findRoute(settings.name);

    if (route != null) {
      final newSettings = route.getSetting(settings.name, arguments);
      return MaterialPageRoute(
        builder: (context) => _routesMapping[route](newSettings.arguments),
        settings: newSettings,
      );
    } else {
      // throw ErrorDescription('Invalid route: ${settings.name}');
      print('Invalid route: ${settings.name}');
      return null;
    }
  }
}
