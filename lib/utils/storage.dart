import 'package:localstorage/localstorage.dart';

const _kFilename = 'data';

class Storage {
  static LocalStorage _storage;

  static Future<void> init([String filename = _kFilename]) async {
    _storage = LocalStorage(_kFilename);
    await _storage.ready;
  }

  static Future<bool> get ready => _storage.ready;
  static Map<String, dynamic> getItem(String key) {
    return _storage.getItem(key);
  }

  static Future<void> setItem(String key, Map<String, dynamic> value) {
    return _storage.setItem(key, value);
  }

  static Future<void> deleteItem(String key) {
    return _storage.deleteItem(key);
  }
}
