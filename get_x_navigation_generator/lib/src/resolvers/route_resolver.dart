import 'package:analyzer/dart/element/element.dart';
import 'package:collection/collection.dart';
import 'package:get_x_navigation_generator/src/models/get_x_route_config.dart';
import 'package:get_x_navigation_generator_interface/get_x_navigation_generator_interface.dart';
import 'package:source_gen/source_gen.dart';

import 'importable_type_resolver.dart';

const TypeChecker _getXRouteChecker = TypeChecker.fromRuntime(GetXRoute);
const TypeChecker _constructorChecker =
    TypeChecker.fromRuntime(GetXRouteConstructor);

class RouteResolver {
  final ImportableTypeResolverImpl _typeResolver;

  RouteResolver(List<LibraryElement> libs)
      : _typeResolver = ImportableTypeResolverImpl(libs);

  GetXRouteConfig resolve(ClassElement clazz) {
    final annotatedElement = clazz;
    var getXRouteAnnotation = _getXRouteChecker.firstAnnotationOf(
      annotatedElement,
      throwOnUnresolved: false,
    );

    final getXRoute = ConstantReader(getXRouteAnnotation);
    final routeName = getXRoute.peek('routeName')?.stringValue ?? clazz.name;
    final returnType = getXRouteAnnotation?.getField('returnType');
    final navigationType = NavigationType.values.firstWhereOrNull((element) =>
        element.index ==
        getXRoute.peek('navigationType')?.peek('index')?.intValue);
    final returnTypeNullable =
        getXRouteAnnotation?.getField('returnTypeNullable')?.toBoolValue() ??
            false;
    final middlewares =
        getXRouteAnnotation?.getField('middlewares')?.toListValue() ?? [];

    final possibleFactories = <ExecutableElement>[
      ...clazz.methods.where((m) => m.isStatic),
      ...clazz.constructors,
    ];

    final constructor = possibleFactories.firstWhere(
      (m) => _constructorChecker.firstAnnotationOf(m) != null,
      orElse: () => clazz.constructors.first,
    );

    return GetXRouteConfig(
      type: _typeResolver.resolveType(annotatedElement.thisType),
      returnType: returnType?.toTypeValue() == null
          ? null
          : _typeResolver.resolveType(
              returnType!.toTypeValue()!,
              forceNullable: returnTypeNullable,
            ),
      constructorName: constructor.name,
      parameters: constructor.parameters
          .map((p) => _typeResolver.resolveType(
                p.type,
                isRequired: p.isRequired,
                name: p.name,
              ))
          .toList(),
      routeName: routeName,
      navigationType: navigationType,
      middlewares: middlewares
          .map((e) => _typeResolver.resolveType(e.toTypeValue()!))
          .toList(),
    );
  }
}
