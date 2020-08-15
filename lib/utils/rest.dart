import 'dart:convert';
import 'dart:io';

import 'package:ezkit/ezkit.dart';
import 'package:http/http.dart' as http;

import 'logger.dart';

enum RestMethod { head, get, post, put, delete, upload }
typedef _Request(
  String url, {
  Map<String, String> headers,
  dynamic body,
});

final List<_Request> _restMethod = [
  (url, {headers, body}) => http.head(url, headers: headers),
  (url, {headers, body}) => http.get(url, headers: headers),
  http.post,
  http.put,
  (url, {headers, body}) => http.delete(url, headers: headers),
  (url, {headers, body}) => Rest._upload(url, body, headers: headers),
];

typedef Future<bool> RestErrorCallbackHandler(
  RestError restException,
  int retryCount,
);

final kContentTypeJson = 'application/json';

class Rest {
  static String _baseURL;
  static Map<String, String> _auth;
  static Map<String, String> _defaultHeaders;
  static bool _forceUTF8;
  static bool _loggerEnabled = true;

  static bool Function(int statusCode) _validateStatus;

  /// Base URL for request
  static set baseURL(String value) => _baseURL = value;

  /// Authorazation header
  static set auth(Map<String, String> value) => _auth = value;

  /// Default headers
  static set defaultHeaders(Map<String, String> value) =>
      _defaultHeaders = value;

  /// Validate status code
  static set validateStatus(Function(int statusCode) value) {
    _validateStatus = value;
  }

  /// handler for rest error
  static RestErrorCallbackHandler _errorCallbackHandler;

  /// In case webserver's Content-Type not include charset utf-8
  /// but the content has utf-8 chars
  static set forceUTF8(bool value) => _forceUTF8 = value;

  /// Logging requests, enabled by default
  static set loggerEnabled(bool value) => _loggerEnabled = value;

  static Future<dynamic> _request(
    RestMethod method,
    String path, {
    Map<String, String> headers,
    // Map<String, String> params,
    dynamic body,
    bool useAuth = false,
    int retryCount = 0,
  }) async {
    // update path
    if (_baseURL != null &&
        path.startsWith(RegExp(r'http(.|):\/\/')) == false) {
      path = _baseURL + path;
    }

    // Update headers: content-type + auth
    headers = {'Content-type': kContentTypeJson}
      ..addAll(_defaultHeaders ?? {})
      ..addAll(headers ?? {});
    if (_auth != null && useAuth) {
      headers.addAll(_auth);
    }

    if (_loggerEnabled) Logger.debug('$method $path');

    // convert body by json or something else
    if (body is Map<String, dynamic> &&
        headers['Content-type'] == kContentTypeJson) {
      body = jsonEncode(body);
    }

    final res = await _restMethod[method.index](
      path,
      headers: headers,
      body: body,
    );

    final statusCode = res.statusCode;
    bool ok = false;

    if (_validateStatus != null) {
      ok = _validateStatus(statusCode);
    } else {
      ok = statusCode == HttpStatus.ok || statusCode == HttpStatus.created;
    }

    dynamic retBody;

    if (res is http.StreamedResponse) {
      final data = await res.stream?.toBytes();
      retBody = String.fromCharCodes(data);
    } else {
      retBody = _forceUTF8 ? utf8.decode(res.bodyBytes) : res.body;
    }

    retBody = res.headers['content-type'] == kContentTypeJson
        ? jsonDecode(retBody)
        : retBody;

    if (ok) {
      return retBody;
    }

    if (_loggerEnabled) Logger.warn(res.body);
    final error = RestError(
      res.statusCode,
      retBody,
    );
    if (_errorCallbackHandler != null) {
      try {
        // need request again or not?
        if (await _errorCallbackHandler(error, retryCount)) {
          return Rest._request(method, path,
              headers: headers,
              body: body,
              useAuth: useAuth,
              retryCount: ++retryCount);
        }
      } catch (e) {
        throw e;
      }
    }
    throw error;
  }

  static Future<dynamic> request(RestMethod method, String path,
      {Map<String, String> headers, dynamic body, bool useAuth = true}) async {
    _request(method, path, headers: headers, body: body, useAuth: useAuth);
  }

  static Future<dynamic> head(String path,
      {Map<String, String> headers, bool useAuth = true}) async {
    return _request(RestMethod.head, path, headers: headers, useAuth: useAuth);
  }

  static Future<dynamic> get(String path,
      {Map<String, String> params,
      Map<String, String> headers,
      bool useAuth = true}) async {
    if (params != null) {
      path += '?' + Uri(queryParameters: params).query;
    }
    return _request(RestMethod.get, path, headers: headers, useAuth: useAuth);
  }

  static Future<dynamic> post(String path,
      {Map<String, String> headers, dynamic body, bool useAuth = true}) async {
    return _request(RestMethod.post, path,
        headers: headers, body: body, useAuth: useAuth);
  }

  static Future<dynamic> put(String path,
      {Map<String, String> headers, dynamic body, bool useAuth = true}) async {
    return _request(RestMethod.put, path,
        headers: headers, body: body, useAuth: useAuth);
  }

  static Future<dynamic> delete(String path,
      {Map<String, String> headers, dynamic body, bool useAuth = true}) async {
    return _request(RestMethod.delete, path,
        headers: headers, useAuth: useAuth);
  }

  static Future<http.StreamedResponse> _upload(String path, FileInfo file,
      {Map<String, String> headers}) async {
    assert(file.content != null || file.path != null);
    Uri uri = Uri.parse(path);
    http.MultipartFile fileContent;
    if (file.content != null) {
      fileContent = http.MultipartFile.fromBytes(
        'file',
        file.content,
        filename: file.name,
      );
    } else {
      fileContent = await http.MultipartFile.fromPath(
        'file',
        file.path,
        filename: file.name,
      );
    }
    final request = http.MultipartRequest('POST', uri);
    request.files.add(fileContent);
    request.headers.addAll({'Content-Type': 'multipart/form-data'});
    final res = await request.send();
    return res;
  }

  static Future<dynamic> upload(String path, FileInfo file,
      {Map<String, String> headers, bool useAuth = true}) async {
    return _request(RestMethod.upload, path,
        headers: headers, body: file, useAuth: useAuth);
  }
}
