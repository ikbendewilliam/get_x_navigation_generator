import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:get_x_navigation_generator/src/annotations.dart';
import 'package:get_x_navigation_generator/src/models/dependency_config.dart';
import 'package:get_x_navigation_generator/src/resolvers/dependency_resolver.dart';
import 'package:get_x_navigation_generator/src/resolvers/importable_type_resolver.dart';
import 'package:source_gen/source_gen.dart';

const TypeChecker _typeChecker = TypeChecker.fromRuntime(GetXRoute);

class InjectableGenerator implements Generator {
  RegExp? _classNameMatcher, _fileNameMatcher;
  late bool _autoRegister;

  InjectableGenerator(Map options) {
    _autoRegister = options['auto_register'] ?? false;
    if (_autoRegister) {
      if (options['class_name_pattern'] != null) {
        _classNameMatcher = RegExp(options['class_name_pattern']);
      }
      if (options['file_name_pattern'] != null) {
        _fileNameMatcher = RegExp(options['file_name_pattern']);
      }
    }
  }

  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) async {
    final allDepsInStep = <DependencyConfig>[];
    for (var clazz in library.classes) {
      if (_hasInjectable(clazz) || (_autoRegister && _hasConventionalMatch(clazz))) {
        allDepsInStep.add(DependencyResolver(
          getResolver(await buildStep.resolver.libraries.toList()),
        ).resolve(clazz));
      }
    }

    return allDepsInStep.isNotEmpty ? jsonEncode(allDepsInStep) : null;
  }

  ImportableTypeResolver getResolver(List<LibraryElement> libs) {
    return ImportableTypeResolverImpl(libs);
  }

  bool _hasInjectable(ClassElement element) {
    return _typeChecker.hasAnnotationOf(element);
  }

  bool _hasConventionalMatch(ClassElement clazz) {
    if (clazz.isAbstract) {
      return false;
    }
    final fileName = clazz.source.shortName.replaceFirst('.dart', '');
    return (_classNameMatcher != null && _classNameMatcher!.hasMatch(clazz.name)) || (_fileNameMatcher != null && _fileNameMatcher!.hasMatch(fileName));
  }
}
