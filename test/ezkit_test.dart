import 'package:ezkit/ezkit.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('simple search', () {
    final List<Map> items = [
      {'id': 1, 'name': 'Sàn phẩm 1'},
      {'id': 2, 'name': 'Sàn phẩm 2'},
      {'id': 2, 'name': 'Sản phẩm 2'},
    ];

    final simpleSearch = SimpleSearch<Map>(items, ['name']);
    expect(simpleSearch.search('san pham').length, 3);
    expect(simpleSearch.search('Sản phẩm').length, 1);
  });
}
