import 'dart:convert';
import 'dart:io';

import 'package:ezkit/ezkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'logger.dart';

const kHttpMethodHead = 'HEAD';
const kHttpMethodGet = 'GET';
const kHttpMethodPost = 'POST';
const kHttpMethodPut = 'PUT';
const kHttpMethodDelete = 'DELETE';

class Rest {
  static String _baseURL;
  static Map<String, String> _auth;
  static bool _forceUTF8;
  static bool _loggerEnabled = true;

  static bool Function(int statusCode) _validateStatus;

  /// Base URL for request
  static set baseURL(String value) => _baseURL = value;

  /// Authorazation header
  static set auth(Map<String, String> value) => _auth = value;

  /// Validate status code
  static set validateStatus(Function(int statusCode) value) {
    _validateStatus = value;
  }

  /// In case webserver's Content-Type not include charset utf-8
  /// but the content has utf-8 chars
  static set forceUTF8(bool value) => _forceUTF8 = value;

  /// Logging requests, enabled by default
  static set loggerEnabled(bool value) => _loggerEnabled = value;

  static Future<dynamic> request(
    String method,
    String path, {
    Map<String, String> headers,
    Map<String, String> params,
    dynamic body,
  }) async {
    // Update headers: content-type + auth
    headers = headers ?? {'Content-type': 'application/json'};
    if (_auth != null) {
      headers.addAll(_auth);
    }

    String url = _baseURL + path;
    http.Response res;

    if (_loggerEnabled) Logger.debug('$method $path');
    switch (method) {
      case kHttpMethodHead:
        res = await http.head(url, headers: headers);
        break;
      case kHttpMethodGet:
        res = await http.get(url, headers: headers);
        break;
      case kHttpMethodPost:
        res = await http.post(url, headers: headers, body: jsonEncode(body));
        break;
      case kHttpMethodPut:
        res = await http.put(url, headers: headers, body: jsonEncode(body));
        break;
      case kHttpMethodDelete:
        res = await http.delete(url, headers: headers);
        break;
    }

    final statusCode = res.statusCode;
    bool ok = false;

    if (_validateStatus != null) {
      ok = _validateStatus(statusCode);
    } else {
      ok = statusCode == HttpStatus.ok || statusCode == HttpStatus.created;
    }

    if (ok) {
      return _forceUTF8 == true
          ? jsonDecode(utf8.decode(res.bodyBytes))
          : jsonDecode(res.body);
    }

    if (_loggerEnabled) Logger.warn(res.body);
    throw ErrorDescription(RestError(
      statusCode,
      _forceUTF8 == true
          ? jsonDecode(utf8.decode(res.bodyBytes))
          : jsonDecode(res.body),
    ).toString());
  }

  static Future<dynamic> head(String path,
      {Map<String, String> headers}) async {
    return request(kHttpMethodHead, path, headers: headers);
  }

  static Future<dynamic> get(String path,
      {Map<String, String> params, Map<String, String> headers}) async {
    if (params != null) {
      path += '?' + Uri(queryParameters: params).query;
    }
    return request(kHttpMethodGet, path, headers: headers);
  }

  static Future<dynamic> post(String path,
      {Map<String, String> headers, dynamic body}) async {
    return request(kHttpMethodPost, path, headers: headers, body: body);
  }

  static Future<dynamic> put(String path,
      {Map<String, String> headers, dynamic body}) async {
    return request('PUT', path, headers: headers, body: body);
  }

  static Future<dynamic> delete(String path,
      {Map<String, String> headers, dynamic body}) async {
    return request('DELETE', path, headers: headers);
  }
}
