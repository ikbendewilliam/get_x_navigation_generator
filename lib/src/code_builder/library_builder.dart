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
                    ..assignment =
                        Code('[${routes.map((route) => "GetPage(name: RouteNames.${CaseUtil(route.routeName).camelCase}, page: () => ${route.type.className}())").join(',')}]'),
                ))
                ..methods.addAll(routes.map((route) {
                  return Method(
                    (b) => b
                      ..name = 'goTo${CaseUtil(route.routeName).upperCamelCase}'
                      ..lambda = true
                      ..requiredParameters.addAll(route.parameters.where((e) => e.isRequired).map((p) => Parameter(
                            (b) => b
                              ..name = p.name ?? p.className
                              ..named = true
                              ..required = true
                              ..type = typeRefer(p, targetFile),
                          )))
                      ..optionalParameters.addAll(route.parameters.where((e) => !e.isRequired).map((p) => Parameter(
                            (b) => b
                              ..name = p.name ?? p.className
                              ..named = true
                              ..required = false
                              ..type = typeRefer(p, targetFile),
                          )))
                      // ..returns = typeRefer(route.type, targetFile) // TODO: Return type?
                      ..body = Code('Get.toNamed<void>(RouteNames.${CaseUtil(route.routeName).camelCase})'),
                  );
                })),
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
