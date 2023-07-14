import 'package:analyzer/dart/constant/value.dart';

dynamic anyValueResolver(DartObject? value) {
  if (value == null) return null;
  return value.toBoolValue() ??
      value.toIntValue() ??
      value.toDoubleValue() ??
      value.toStringValue();
}
