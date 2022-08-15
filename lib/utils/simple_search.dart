
final _kAccents =
    'ÀÁẢÃẠÂẦẤẨẪẬĂẰẮẲẴẶĐÈÉẺẼẸÊỀẾỂỄỆÍÌỈĨỊÒÓỎÕỌÔỒỒỔỖỘƠỜỚỞỠỢÙÚỦŨỤƯỪỨỬỮỰỲÝỶỸỴàáảãạâầấẩẫậăằắẳẵặđèéẻẽẹêềếểễệíìỉĩịòóỏõọôồồổỗộơờớởỡợùúủũụưừứửữựỳýỷỹỵ'
        .runes;
final _kASCII =
    'AAAAAAAAAAAAAAAAADEEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOOOUUUUUUUUUuUYYYYYaaaaaaaaaaaaaaaaadeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyy'
        .runes;

class SimpleSearchData<T> {
  List<T> items;
  List<String> texts;

  SimpleSearchData({required this.items, this.texts = const []});
}

class SimpleSearch<T> {
  static Map<String, String> _map = {};
  late SimpleSearchData<T> _data;

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
      final List<String> texts = [];
      for (final f in fields) {
        texts.add(this.normalize(e[f]));
      }
      this._data.texts.add(texts.join(' ').toLowerCase());
    }
  }

  List<T> search(String value) {
    final List<T> items = [];
    for (int i = 0; i < this._data.texts.length; i++) {
      if (this._data.texts[i].contains(this.normalize(value).toLowerCase())) {
        items.add(this._data.items[i]);
      }
    }

    return items;
  }

  String normalize(String value) {
    return value.splitMapJoin(
      RegExp(r'[\x00-\x7f]'),
      onNonMatch: this._onNonMatch as String Function(String)?,
    );
  }

  String? _onNonMatch(String value) {
    return _map[value] != null ? _map[value] : value;
  }
}
