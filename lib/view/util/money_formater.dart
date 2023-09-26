import 'package:intl/intl.dart';

final _percentFormatter = NumberFormat.percentPattern();

String format(String currencyCode, double value) {
  return NumberFormat.simpleCurrency(name: currencyCode).format(value);
}

String formatWithoutZero(String currencyCode, double value) {
  final str = NumberFormat.simpleCurrency(name: currencyCode).format(value);
  return str.endsWith('00') ? str.substring(0, str.length - 3) : str;
}

String compactFormat(String currencyCode, double value) {
  return NumberFormat.compactCurrency(name: currencyCode).format(value);
}

String percentFormat(double value) {
  return _percentFormatter.format(value);
}
