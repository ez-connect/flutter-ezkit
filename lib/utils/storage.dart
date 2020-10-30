import 'package:localstorage/localstorage.dart';

const _kFilename = 'data';

class Storage {
  static LocalStorage _storage;

  static Future<void> init([String filename = _kFilename, String path]) async {
    _storage = LocalStorage(filename, path);
    await _storage.ready;
  }

  static Future<bool> get ready => _storage.ready;

  static dynamic getItem(String key) {
    return _storage.getItem(key);
  }

  static Future<void> setItem(String key, dynamic value) {
    return _storage.setItem(key, value);
  }

  static Future<void> deleteItem(String key) {
    return _storage.deleteItem(key);
  }
}
