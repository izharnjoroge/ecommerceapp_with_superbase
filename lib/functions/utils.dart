import 'package:intl/intl.dart';

class UtilitiesFunctions {
  String formatAmountWithSymbol(double amount, String locale) {
    final format = NumberFormat.currency(locale: locale, symbol: '');
    return format.format(amount);
  }
}
