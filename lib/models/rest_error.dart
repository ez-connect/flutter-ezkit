import 'dart:convert';

/// Describe an error if validate the status code failure.
/// Call [Rest.setValidateStatus] to use a custom validate,
/// default `statusCode == 200 || statusCode == 202`
class RestError {
  int? statusCode;
  dynamic body;
  String? path;
  RestError(this.statusCode, this.body, this.path);

  Map<String, dynamic> toMap() {
    return {
      'statusCode': statusCode,
      'body': body,
      'path': path,
    };
  }

  String toString() {
    return jsonEncode(this.toMap());
  }

  factory RestError.fromMap(Map<String, dynamic> map) {
    if (map == null) {
      NullThrownError();
    }

    return RestError(map['statusCode'], map['name'], map['path']);
  }
}
