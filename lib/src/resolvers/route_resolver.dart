import 'package:analyzer/dart/element/element.dart';
import 'package:get_x_navigation_generator/src/annotations.dart';
import 'package:get_x_navigation_generator/src/models/get_x_route_config.dart';
import 'package:source_gen/source_gen.dart';

import 'importable_type_resolver.dart';

const TypeChecker _getXRouteChecker = TypeChecker.fromRuntime(GetXRoute);

class RouteResolver {
  final ImportableTypeResolverImpl _typeResolver;

  RouteResolver(List<LibraryElement> libs) : _typeResolver = ImportableTypeResolverImpl(libs);

  GetXRouteConfig resolve(ClassElement clazz) {
    final annotatedElement = clazz;
    var getXRouteAnnotation = _getXRouteChecker.firstAnnotationOf(
      annotatedElement,
      throwOnUnresolved: false,
    );

    final getXRoute = ConstantReader(getXRouteAnnotation);
    final routeName = getXRoute.peek('routeName')?.stringValue ?? clazz.name;

    final constructor = clazz.constructors.first; // TODO: Support defining which constructor to use
    // late ExecutableElement executableInitializer;
    // final possibleFactories = <ExecutableElement>[
    //   ...clazz.methods.where((m) => m.isStatic),
    //   ...clazz.constructors,
    // ];

    // executableInitializer = possibleFactories.firstWhere(
    //   (m) {
    //     final annotation = _factoryMethodChecker.firstAnnotationOf(m);
    //     if (annotation != null) {
    //       _preResolve |= annotation.getField('preResolve')!.toBoolValue() ?? false;
    //       return true;
    //     }
    //     return false;
    //   },
    //   orElse: () {
    //     throwIf(
    //       clazz.isAbstract,
    //       '''[${clazz.name}] is abstract and can not be registered directly! \nif it has a factory or a create method annotate it with @factoryMethod''',
    //       element: clazz,
    //     );
    //     return clazz.unnamedConstructor as ExecutableElement;
    //   },
    // );

    return GetXRouteConfig(
      type: _typeResolver.resolveType(annotatedElement.thisType),
      constructorName: constructor.name,
      parameters: constructor.parameters.map((p) => _typeResolver.resolveType(p.type, p.isRequired, p.name)).toList(),
      routeName: routeName,
    );
  }
}
