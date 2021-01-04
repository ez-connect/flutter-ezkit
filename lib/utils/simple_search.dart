import 'package:meta/meta.dart';

final _kAccents =
    'ÀÁẢÃẠÂẤẨẪẬĂẮẰẲẴẶÃÄÅàáãạâấẩẫậăắằẳẵäåÒÓÔÕÕÖØòóôõöøÈÉẺẼẸÊẾỂỄỆËèéẻẽẹêếểễệëðÇçÐÌÍỈĨỊÎÏìíỉĩịîïÙÚỦŨỤƯỪỨỮỰÛÜùúủũụưừứữựûüÑñŠšŸÿýŽž'
        .runes;
final _kASCII =
    'AAAAAAAAAAAAAAAAAAAaaaaaaaaaaaaaaaaOOOOOOOooooooEEEEEEEEEEEeeeeeeeeeeedCcDIIIIIIIiiiiiiiUUUUUUUUUUUUuuuuuuuuuuuuNnSsYyyZz'
        .runes;

class SimpleSearchData<T> {
  List<T> items;
  List<String> texts;

  SimpleSearchData({@required this.items, this.texts = const []});
}

class SimpleSearch<T> {
  static Map<String, String> _map = {};
  SimpleSearchData<T> _data = SimpleSearchData();

  SimpleSearch(List<T> items, List<String> fields) {
    if (_map.isEmpty) {
      for (int i = 0; i < _kAccents.length; i++) {
        final key = String.fromCharCode(_kAccents.elementAt(i));
        final value = String.fromCharCode(_kASCII.elementAt(i));
        _map[key] = value;
      }
    }

    this._data = SimpleSearchData(items: [], texts: []);
    for (final dynamic e in items) {
      this._data.items.add(e);
      String text = '';
      for (final f in fields) {
        text += this.normalize(e[f].trim());
      }
      this._data.texts.add(text.toLowerCase());
    }
  }

  List<T> search(String value) {
    final List<T> items = [];
    for (int i = 0; i < this._data.texts.length; i++) {
      if (this._data.texts[i].contains(value.toLowerCase())) {
        items.add(this._data.items[i]);
      }
    }

    return items;
  }

  String normalize(String value) {
    return value.splitMapJoin(
      RegExp(r'[\x00-\x7f]'),
      onNonMatch: this._onNonMatch,
    );
  }

  String _onNonMatch(String value) {
    return _map[value] != null ? _map[value] : value;
  }
}
