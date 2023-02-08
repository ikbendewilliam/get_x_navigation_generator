import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:get_x_navigation_generator/src/code_builder/library_builder.dart';
import 'package:get_x_navigation_generator/src/models/get_x_route_config.dart';
import 'package:get_x_navigation_generator/src/resolvers/importable_type_resolver.dart';
import 'package:get_x_navigation_generator_annotations/get_x_navigation_generator_annotations.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';

class GetXNavigationConfigGenerator
    extends GeneratorForAnnotation<GetXNavigator> {
  static const _navigatorClassNameDefault = 'BaseNavigator';

  @override
  dynamic generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    final typeResolver =
        ImportableTypeResolverImpl(await buildStep.resolver.libraries.toList());
    final configFiles = Glob("**.get_x_navigation.json");
    final navigatorClassName =
        annotation.peek('navigatorClassName')?.stringValue;
    final pageTypeAsDartType = annotation.peek('pageType')?.typeValue;
    final removeSuffixes = annotation
            .peek('removeSuffixes')
            ?.listValue
            .map((e) => e.toStringValue())
            .whereType<String>()
            .toList() ??
        [];
    final pageType = pageTypeAsDartType == null
        ? null
        : typeResolver.resolveType(pageTypeAsDartType);
    final jsonData = <Map>[];

    await for (final id in buildStep.findAssets(configFiles)) {
      final dynamic json = jsonDecode(await buildStep.readAsString(id));
      jsonData.addAll((json as List).map((dynamic e) => e as Map).toList());
    }

    final routes = <GetXRouteConfig>{};
    for (final json in jsonData) {
      routes.add(GetXRouteConfig.fromMap(json as Map<String, dynamic>));
    }

    final generator = LibraryGenerator(
      routes: routes,
      className: navigatorClassName ?? _navigatorClassNameDefault,
      targetFile: element.source?.uri,
      pageType: pageType,
      removeSuffixes: removeSuffixes,
    );

    final generatedLib = generator.generate();

    final emitter = DartEmitter(
      allocator: Allocator.simplePrefixing(),
      orderDirectives: true,
    );

    return DartFormatter().format(generatedLib.accept(emitter).toString());
  }
}
