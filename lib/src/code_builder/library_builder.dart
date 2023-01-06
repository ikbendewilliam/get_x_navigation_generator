import 'package:code_builder/code_builder.dart';
import 'package:get_x_navigation_generator/src/case_utils.dart';
import 'package:get_x_navigation_generator/src/models/get_x_route_config.dart';
import 'package:get_x_navigation_generator/src/utils.dart';

class LibraryGenerator {
  late Set<GetXRouteConfig> routes;
  final String className;
  final Uri? targetFile;

  LibraryGenerator({
    required this.routes,
    required this.className,
    this.targetFile,
  });

  Library generate() {
    return Library(
      (b) => b
        ..directives.addAll([
          Directive.import('package:get/route_manager.dart'),
          ...routes.map((route) => route.type.import).whereType<String>().map((import) => Directive.import(import)),
        ])
        ..body.addAll(
          [
            Class(
              (b) => b
                ..name = className
                ..fields.add(Field(
                  (b) => b
                    ..name = 'pages'
                    ..static = true
                    ..modifier = FieldModifier.final$
                    ..assignment = literalList(routes.map((route) => const Reference('GetPage').call([], {
                          'name': Reference('RouteNames.${CaseUtil(route.routeName).camelCase}'),
                          'page': Method(
                            (b) => b
                              ..name = ''
                              ..body = Reference(route.type.className).call(
                                  [],
                                  route.parameters
                                      .asMap()
                                      .map((_, p) => MapEntry(p.argumentName, Reference("Get.arguments['${p.argumentName}']").asA(typeRefer(p, targetFile: targetFile))))).code,
                          ).closure,
                        }))).code,
                ))
                ..methods.addAll(routes.map((route) => Method(
                      (b) => b
                        ..name = 'goTo${CaseUtil(route.routeName).upperCamelCase}'
                        ..lambda = true
                        ..modifier = MethodModifier.async
                        ..optionalParameters.addAll(route.parameters.map((p) => Parameter(
                              (b) => b
                                ..name = p.argumentName
                                ..named = true
                                ..required = p.isRequired
                                ..type = typeRefer(p, targetFile: targetFile),
                            )))
                        ..returns = typeRefer(
                          route.returnType,
                          targetFile: targetFile,
                          forceNullable: true,
                          forceFuture: true,
                        )
                        ..body = TypeReference(
                          (b) => b
                            ..symbol = 'Get.toNamed'
                            ..types.add(typeRefer(route.returnType, targetFile: targetFile)),
                        ).call(
                          [
                            Reference('RouteNames.${CaseUtil(route.routeName).camelCase}'),
                          ],
                          {'arguments': Reference('${route.parameters.asMap().map((_, p) => MapEntry("'${p.argumentName}'", p.argumentName))}')},
                        ).code,
                    ))),
            ),
            Class(
              (b) => b
                ..name = 'RouteNames'
                ..fields.addAll(routes.map((route) {
                  return Field(
                    (b) => b
                      ..name = CaseUtil(route.routeName).camelCase
                      ..static = true
                      ..modifier = FieldModifier.constant
                      ..assignment = Code("'${route.routeName}'"),
                  );
                })),
            ),
          ],
        ),
    );
  }
}
