// general utils
import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:get_x_navigation_generator/src/models/importable_type.dart';
import 'package:get_x_navigation_generator/src/resolvers/importable_type_resolver.dart';
import 'package:source_gen/source_gen.dart';

String capitalize(String s) {
  if (s.length < 2) {
    return s.toUpperCase();
  }
  return s[0].toUpperCase() + s.substring(1);
}

String toCamelCase(String s) {
  if (s.length < 2) {
    return s.toLowerCase();
  }
  return s[0].toLowerCase() + s.substring(1);
}

void throwBoxed(String message) {
  const pre = 'Injectable Generator ';
  throw ("\n${pre.padRight(72, '-')}\n$message\n${''.padRight(72, '-')} \n");
}

void throwSourceError(String message) {
  const pre = 'Injectable Generator ';
  throw ("\n${pre.padRight(72, '-')}\n$message\n${''.padRight(72, '-')} \n");
}

void throwError(String message, {Element? element}) {
  throw InvalidGenerationSourceError(
    message,
    element: element,
  );
}

void throwIf(bool condition, String message, {Element? element}) {
  if (condition) {
    throw InvalidGenerationSourceError(
      message,
      element: element,
    );
  }
}

void printBoxed(String message, {String header = '--------------------------'}) {
  final pre = header;
  // ignore: avoid_print
  print("$pre\n$message\n${''.padRight(72, '-')} \n");
}

Reference typeRefer(ImportableType type, [Uri? targetFile, bool withNullabilitySuffix = true]) {
  final relativeImport = targetFile == null ? ImportableTypeResolver.resolveAssetImport(type.import) : ImportableTypeResolver.relative(type.import, targetFile);
  return TypeReference((reference) {
    reference
      ..symbol = '${type.className}${withNullabilitySuffix && type.isNullable && !type.className.endsWith('?') ? '?' : ''}'
      ..url = relativeImport
      ..isNullable = withNullabilitySuffix && type.isNullable;
    if (type.typeArguments.isNotEmpty) {
      reference.types.addAll(
        type.typeArguments.map((e) => typeRefer(e, targetFile, withNullabilitySuffix)),
      );
    }
  });
}
