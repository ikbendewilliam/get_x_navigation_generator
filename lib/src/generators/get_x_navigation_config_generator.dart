import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:get_x_navigation_generator/src/annotations.dart';
import 'package:get_x_navigation_generator/src/code_builder/library_builder.dart';
import 'package:get_x_navigation_generator/src/models/get_x_route_config.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';

class GetXNavigationConfigGenerator extends GeneratorForAnnotation<GetXNavigator> {
  @override
  dynamic generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) async {
    final configFiles = Glob("**.get_x_navigation.json");

    final jsonData = <Map>[];
    await for (final id in buildStep.findAssets(configFiles)) {
      final json = jsonDecode(await buildStep.readAsString(id));
      jsonData.addAll((json as List).map((e) => e as Map).toList());
    }

    final routes = <GetXRouteConfig>{};
    for (final json in jsonData) {
      routes.add(GetXRouteConfig.fromMap(json as Map<String, dynamic>));
    }

    final generator = LibraryGenerator(
      routes: routes,
      className: 'BaseNavigator', // TODO: Customizable class name
      targetFile: element.source?.uri,
    );

    final generatedLib = generator.generate();

    final emitter = DartEmitter(
      allocator: Allocator.simplePrefixing(),
      orderDirectives: true,
    );

    return DartFormatter().format(generatedLib.accept(emitter).toString());
  }
}
