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
  static String _baseUrl;
  static String _token;

  static bool Function(int statusCode) _validateStatus;

  static void setBaseUrl(String value) {
    _baseUrl = value;
  }

  static void setToken(String value) {
    if (_token != value) {
      _token = value;
    }
  }

  static void setValidateStatus(Function(int statusCode) value) {
    _validateStatus = value;
  }

  // TODO: Use http.HttpClientRequest for better
  static Future<dynamic> request(
    String method,
    String path, {
    Map<String, String> headers,
    Map<String, String> params,
    dynamic body,
  }) async {
    // Update headers: content-type + auth
    headers = headers ?? {'Content-type': 'application/json;charset=utf-8'};
    if (_token != null) {
      headers.addAll({'Private-Token': _token});
    }

    String url = _baseUrl + path;
    Logger.debug('$method $path');
    http.Response res;
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
    body = jsonDecode(utf8.decode(res.bodyBytes));
    if (_validateStatus != null) {
      if (_validateStatus(res.statusCode)) {
        return body;
      }

      throw ErrorDescription(body);
    }

    bool hasError = false;
    if (_validateStatus != null) {
      hasError = _validateStatus(statusCode);
    } else {
      hasError = res.statusCode == HttpStatus.ok ||
          res.statusCode == HttpStatus.created;
    }

    if (!hasError) {
      return jsonDecode(body);
    } else {
      Logger.warn(res.body);
      throw ErrorDescription(RestError(statusCode, body).toString());
    }
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
