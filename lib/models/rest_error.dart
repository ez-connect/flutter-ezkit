import 'dart:convert';

/// Describe an error if validate the status code failure.
/// Call [Rest.setValidateStatus] to use a custom validate,
/// default `statusCode == 200 || statusCode == 202`
class RestError {
  int statusCode;
  dynamic body;

  RestError(this.statusCode, this.body);

  Map<String, dynamic> toMap() {
    return {
      'statusCode': statusCode,
      'body': body,
    };
  }

  String toString() {
    return jsonEncode(this.toMap());
  }

  factory RestError.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RestError(map['statusCode'], map['name']);
  }
}
