import 'package:code_builder/code_builder.dart';
import 'package:get_x_navigation_generator/src/case_utils.dart';
import 'package:get_x_navigation_generator/src/extensions/navigation_type_extension.dart';
import 'package:get_x_navigation_generator/src/models/get_x_route_config.dart';
import 'package:get_x_navigation_generator/src/models/importable_type.dart';
import 'package:get_x_navigation_generator/src/utils.dart';
import 'package:get_x_navigation_generator_annotations/get_x_navigation_generator_annotations.dart';

class LibraryGenerator {
  late Set<GetXRouteConfig> routes;
  final String className;
  final Uri? targetFile;
  final ImportableType? pageType;
  final List<String> removeSuffixes;

  LibraryGenerator({
    required this.routes,
    required this.className,
    this.targetFile,
    this.pageType,
    this.removeSuffixes = const [],
  });

  Library generate() {
    return Library(
      (b) => b
        ..directives.addAll([
          Directive.import('package:get/route_manager.dart'),
        ])
        ..body.addAll(
          [
            Class((b) => b
              ..name = className
              ..fields.add(Field(
                (b) => b
                  ..name = 'pages'
                  ..static = true
                  ..modifier = FieldModifier.final$
                  ..assignment = literalList(routes
                          .where((route) => route.generatePage)
                          .map((route) => TypeReference(
                                (b) {
                                  final pageTypeRef = pageType == null
                                      ? null
                                      : typeRefer(pageType!,
                                          targetFile: targetFile);
                                  b
                                    ..symbol = pageTypeRef?.symbol ?? 'GetPage'
                                    ..url = pageTypeRef?.url
                                    ..types.add(route.returnType != null
                                        ? typeRefer(route.returnType!,
                                            targetFile: targetFile)
                                        : const Reference('dynamic'));
                                },
                              ).call([], {
                                'name': Reference(
                                    'RouteNames.${CaseUtil(route.routeName).camelCase}'),
                                'page': Method(
                                  (b) => b
                                    ..name = ''
                                    ..body = Reference(
                                      route.constructorName ==
                                                  route.type.className ||
                                              route.constructorName.isEmpty
                                          ? route.type.className
                                          : '${route.type.className}.${route.constructorName}',
                                      typeRefer(route.type,
                                              targetFile: targetFile)
                                          .url,
                                    ).call(
                                        [],
                                        route.parameters.asMap().map((_, p) =>
                                            MapEntry(
                                                p.argumentName,
                                                Reference(
                                                        "Get.arguments?['${p.argumentName}']")
                                                    .asA(typeRefer(
                                                        p,
                                                        targetFile:
                                                            targetFile))))).code,
                                ).closure,
                                if (route.middlewares.isNotEmpty)
                                  'middlewares': literalList(route.middlewares
                                      .map((middleware) => typeRefer(middleware,
                                              targetFile: targetFile)
                                          .call([]))
                                      .toList()),
                                if (route.isFullscreenDialog)
                                  'fullscreenDialog': literalBool(true),
                              }))
                          .toList())
                      .code,
              ))
              ..methods.addAll(routes
                  .where((route) =>
                      route.generateMethod &&
                      route.navigationType != NavigationType.dialog)
                  .map((route) {
                final bodyCall = TypeReference(
                  (b) => b
                    ..symbol = 'Get.${route.navigationTypeAsString}'
                    ..types.add(const Reference('dynamic')),
                ).call(
                  [
                    Reference(
                        'RouteNames.${CaseUtil(route.routeName).camelCase}'),
                  ],
                  {
                    'arguments': Reference(
                        '${route.parameters.asMap().map((_, p) => MapEntry("'${p.argumentName}'", p.argumentName))}')
                  },
                );
                Code body;
                if (route.returnType != null) {
                  body = Block((b) => b
                    ..statements.add(
                        declareFinal('result', type: const Reference('dynamic'))
                            .assign(bodyCall.awaited)
                            .statement)
                    ..statements.add(const Reference('result')
                        .asA(typeRefer(route.returnType,
                            targetFile: targetFile, forceNullable: true))
                        .returned
                        .statement));
                } else {
                  body = bodyCall.code;
                }
                return Method(
                  (b) {
                    final isAsync = route.navigationType.isAsync ||
                        route.returnType != null;
                    b
                      ..name = 'goTo${CaseUtil(route.routeName).upperCamelCase}'
                      ..lambda = route.returnType == null
                      ..modifier = isAsync ? MethodModifier.async : null
                      ..optionalParameters
                          .addAll(route.parameters.map((p) => Parameter(
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
                        forceFuture: isAsync,
                      )
                      ..body = body;
                  },
                );
              }))
              ..methods.addAll(routes
                  .where(
                      (route) => route.navigationType == NavigationType.dialog)
                  .map((route) {
                final body = TypeReference((b) => b
                  ..symbol = 'showCustomDialog'
                  ..types.add(route.returnType == null
                      ? const Reference('dynamic')
                      : typeRefer(route.returnType!,
                          targetFile: targetFile))).call(
                  [],
                  {
                    'widget': Reference(
                      route.constructorName == route.type.className ||
                              route.constructorName.isEmpty
                          ? route.type.className
                          : '${route.type.className}.${route.constructorName}',
                      typeRefer(route.type, targetFile: targetFile).url,
                    ).call(
                        [],
                        route.parameters.asMap().map((_, p) => MapEntry(
                            p.argumentName, Reference(p.argumentName)))),
                  },
                ).code;
                return Method(
                  (b) {
                    b
                      ..name = 'show${CaseUtil(route.routeName).upperCamelCase}'
                      ..lambda = true
                      ..modifier = MethodModifier.async
                      ..optionalParameters
                          .addAll(route.parameters.map((p) => Parameter(
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
                      ..body = body;
                  },
                );
              }))
              ..methods.add(Method(
                (b) => b
                  ..name = 'goBack'
                  ..lambda = true
                  ..types.add(const Reference('T'))
                  ..optionalParameters.add(Parameter(
                    (b) => b
                      ..name = 'result'
                      ..named = true
                      ..type = const Reference('T?'),
                  ))
                  ..returns = const Reference('void')
                  ..body = const Reference('Get.back<T>')
                      .call([], {'result': const Reference('result')}).code,
              ))
              ..methods.add(Method(
                (b) => b
                  ..name = 'closeDialog'
                  ..lambda = true
                  ..returns = const Reference('void')
                  ..body = const Reference('goBack<void>').call([]).code,
              ))
              ..methods.add(Method(
                (b) => b
                  ..name = 'popUntil'
                  ..lambda = true
                  ..requiredParameters.add(Parameter(
                    (b) => b
                      ..name = 'predicate'
                      ..type = FunctionType((b) => b
                        ..returnType = const Reference('bool')
                        ..requiredParameters.add(const Reference(
                            'Route<dynamic>',
                            'package:flutter/material.dart'))),
                  ))
                  ..returns = const Reference('void')
                  ..body = const Reference('Get.until')
                      .call([const Reference('predicate')]).code,
              ))
              ..methods.add(Method(
                (b) => b
                  ..name = 'goBackTo'
                  ..lambda = true
                  ..requiredParameters.add(Parameter((b) => b
                    ..name = 'routeName'
                    ..type = const Reference('String')))
                  ..returns = const Reference('void')
                  ..body = const Reference('Get.until').call([
                    const Reference('(route) => Get.currentRoute == routeName')
                  ]).code,
              ))
              ..methods.add(Method(
                (b) => b
                  ..name = 'showCustomDialog'
                  ..lambda = true
                  ..modifier = MethodModifier.async
                  ..types.add(const Reference('T'))
                  ..optionalParameters.add(Parameter(
                    (b) => b
                      ..name = 'widget'
                      ..named = true
                      ..type = const Reference(
                          'Widget?', 'package:flutter/material.dart'),
                  ))
                  ..returns = const Reference('Future<T?>')
                  ..body = const Reference('Get.dialog<T>').call([
                    const Reference('widget').ifNullThen(const Reference(
                            'SizedBox.shrink', 'package:flutter/material.dart')
                        .constInstance([]))
                  ]).code,
              ))),
            Class(
              (b) {
                final pageRoutes = routes.where(
                    (route) => route.navigationType != NavigationType.dialog);
                final routesMap = pageRoutes.toList().asMap().map((_, value) =>
                    MapEntry(value.routeName, value.routeNameIsDefined));
                b
                  ..name = 'RouteNames'
                  ..fields.addAll(routesMap.entries.map((entry) {
                    return Field(
                      (b) => b
                        ..name = CaseUtil(entry.key).camelCase
                        ..static = true
                        ..modifier = FieldModifier.constant
                        ..assignment = Code(
                            "'${entry.key.startsWith('/') ? '' : '/'}${entry.value ? entry.key : CaseUtil(entry.key, removeSuffixes: removeSuffixes).textWithoutSuffix}'"),
                    );
                  }));
              },
            ),
          ],
        ),
    );
  }
}
