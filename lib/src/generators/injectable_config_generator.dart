import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:get_x_navigation_generator/get_x_navigation_generator.dart';
import 'package:get_x_navigation_generator/src/code_builder/library_builder.dart';
import 'package:get_x_navigation_generator/src/models/dependency_config.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';

class InjectableConfigGenerator extends GeneratorForAnnotation<GetXNavigator> {
  @override
  dynamic generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) async {
    var targetFile = element.source?.uri;
    final configFiles = Glob("**.get_x_navigation.json");

    final jsonData = <Map>[];
    await for (final id in buildStep.findAssets(configFiles)) {
      final json = jsonDecode(await buildStep.readAsString(id));
      jsonData.addAll([...json]);
    }

    final deps = <DependencyConfig>[];
    for (final json in jsonData) {
      deps.add(DependencyConfig.fromJson(json));
    }

    final generator = LibraryGenerator(
      dependencies: Set.of(deps),
      targetFile: targetFile,
      initializerName: element.displayName,
    );

    final generatedLib = generator.generate();
    final emitter = DartEmitter(
      allocator: Allocator.simplePrefixing(),
      orderDirectives: true,
    );

    final output = DartFormatter().format(generatedLib.accept(emitter).toString());

    return output;
  }
}
