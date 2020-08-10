import 'package:intl/intl.dart';

class Formatter {
  static String currency(double value, [String locale = 'vi_VN']) {
    if (value == null) {
      value = 0;
    }

    final formatter = NumberFormat.currency(locale: locale, symbol: '₫');
    return formatter.format(value.round());
  }

  static String rating(double value, [String locale = 'vi_VN']) {
    if (value == null) {
      return '0';
    }

    final formatter = NumberFormat('#.#', locale);
    return formatter.format(value);
  }

  static String date(DateTime date) {
    if (date == null) {
      return '';
    }

    final formatter = DateFormat('dd/MM/yyyy', 'vi_VN');
    return formatter.format(date);
  }

  static String name(String firstname, String lastname) {
    return '$firstname $lastname';
  }

  static String sentence(String value) {
    if (value == null || value.length == 0) {
      return value;
    }

    final firstChar = value.substring(0, 1).toUpperCase();
    final rest = value.substring(1);
    return '$firstChar$rest';
  }
}
