import 'package:analyzer/dart/element/element.dart';
import 'package:collection/collection.dart';
import 'package:get_x_navigation_generator/src/case_utils.dart';
import 'package:get_x_navigation_generator/src/models/get_x_route_config.dart';
import 'package:get_x_navigation_generator_annotations/get_x_navigation_generator_annotations.dart';
import 'package:source_gen/source_gen.dart';

import 'importable_type_resolver.dart';

const TypeChecker _getXRouteChecker = TypeChecker.fromRuntime(GetXRoute);
const TypeChecker _constructorChecker =
    TypeChecker.fromRuntime(GetXRouteConstructor);

class RouteResolver {
  final ImportableTypeResolverImpl _typeResolver;

  RouteResolver(List<LibraryElement> libs)
      : _typeResolver = ImportableTypeResolverImpl(libs);

  List<GetXRouteConfig> resolve(ClassElement clazz) {
    final annotatedElement = clazz;
    final getXRouteAnnotations = _getXRouteChecker
        .annotationsOf(annotatedElement, throwOnUnresolved: false);
    return getXRouteAnnotations.map((getXRouteAnnotation) {
      final getXRoute = ConstantReader(getXRouteAnnotation);
      final routeNameValue = getXRoute.peek('routeName')?.stringValue;
      final routeName = routeNameValue ?? CaseUtil(clazz.name).kebabCase;
      final returnType = getXRoute.peek('returnType')?.typeValue;
      final navigationType = NavigationType.values.firstWhereOrNull((element) =>
          element.index ==
          getXRoute.peek('navigationType')?.peek('index')?.intValue);
      final preventDuplicates =
          getXRoute.peek('preventDuplicates')?.boolValue ?? true;
      final returnTypeNullable =
          getXRoute.peek('returnTypeNullable')?.boolValue ?? false;
      final middlewares = getXRoute.peek('middlewares')?.listValue ?? [];

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
        returnType: returnType == null
            ? null
            : _typeResolver.resolveType(
                returnType,
                forceNullable: returnTypeNullable,
              ),
        preventDuplicates: preventDuplicates,
        constructorName: constructor.name,
        parameters: constructor.parameters
            .map((p) => _typeResolver.resolveType(
                  p.type,
                  isRequired: p.isRequired,
                  name: p.name,
                ))
            .toList(),
        routeName: routeName,
        routeNameIsDefined: routeNameValue != null,
        navigationType: navigationType,
        middlewares: middlewares
            .map((e) => _typeResolver.resolveType(e.toTypeValue()!))
            .toList(),
        isFullscreenDialog:
            getXRoute.peek('isFullscreenDialog')?.boolValue ?? false,
        generateMethod: getXRoute.peek('generateMethod')?.boolValue ?? true,
        generatePage: (getXRoute.peek('generatePage')?.boolValue ?? true) &&
            navigationType != NavigationType.dialog,
      );
    }).toList();
  }
}
