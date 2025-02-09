import 'package:intl/intl.dart';

class MoneyHelper {
  static String formatToVND(double value) {
    final NumberFormat currencyFormatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫', decimalDigits: 0,);
    return currencyFormatter.format(value).replaceAll('.', ',');
  }
}