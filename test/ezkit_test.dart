import 'package:ezkit/ezkit.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('simple search', () {
    final List<Map> items = [
      {'id': 1, 'name': 'Sàn phẩm 1'},
      {'id': 2, 'name': 'Sàn phẩm 2'},
      {'id': 2, 'name': 'Sản phẩm 2'},
      {'id': 2, 'name': 'Trà sữa trà đen'},
      {'id': 2, 'name': 'Trà sữa ô long'},
    ];

    final simpleSearch = SimpleSearch<Map>(items, ['name']);
    expect(simpleSearch.search('san pham').length, 3);
    expect(simpleSearch.search('Sản phẩm').length, 3);
    expect(simpleSearch.search('tra sua').length, 2);
    expect(simpleSearch.search('Trà sư').length, 2);
  });
}
