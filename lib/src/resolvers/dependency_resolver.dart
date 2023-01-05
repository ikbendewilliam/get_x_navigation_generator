import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:get_x_navigation_generator/src/annotations.dart';
import 'package:get_x_navigation_generator/src/models/dependency_config.dart';
import 'package:get_x_navigation_generator/src/models/importable_type.dart';
import 'package:get_x_navigation_generator/src/models/injected_dependency.dart';
import 'package:get_x_navigation_generator/src/models/module_config.dart';
import 'package:get_x_navigation_generator/src/utils.dart';
import 'package:source_gen/source_gen.dart';

import 'importable_type_resolver.dart';

const TypeChecker _getXRouteChecker = TypeChecker.fromRuntime(GetXRoute);

class DependencyResolver {
  final ImportableTypeResolver _typeResolver;

  late ImportableType _type;
  late ImportableType _typeImpl;
  bool? _signalsReady;
  final List<ImportableType> _dependsOn = [];
  String? _routeName;
  String? _constructorName;
  final List<InjectedDependency> _dependencies = [];
  ModuleConfig? _moduleConfig;

  DependencyResolver(this._typeResolver);

  DependencyConfig resolve(ClassElement element) {
    _type = _typeResolver.resolveType(element.thisType);
    return _resolveActualType(element);
  }

  DependencyConfig resolveModuleMember(
    ClassElement moduleClazz,
    ExecutableElement executableElement,
  ) {
    var moduleType = _typeResolver.resolveType(moduleClazz.thisType);
    var initializerName = executableElement.name;
    var isAbstract = false;

    final returnType = executableElement.returnType;
    throwIf(
      returnType.element is! ClassElement,
      '${returnType.getDisplayString(withNullability: false)} is not a class element',
      element: returnType.element,
    );

    Element? clazz;
    var type = returnType;
    if (executableElement.isAbstract) {
      clazz = returnType.element;
      isAbstract = true;
      throwIf(
        executableElement.parameters.isNotEmpty,
        'Abstract methods can not have a getX route',
        element: executableElement,
      );
    } else {
      if (returnType.isDartAsyncFuture) {
        final typeArg = returnType as ParameterizedType;
        clazz = typeArg.typeArguments.first.element;
        type = typeArg.typeArguments.first;
      } else {
        clazz = returnType.element;
      }
    }
    _moduleConfig = ModuleConfig(
      isAbstract: isAbstract,
      type: moduleType,
      initializerName: initializerName,
    );
    _type = _typeResolver.resolveType(type);
    return _resolveActualType(clazz as ClassElement);
  }

  DependencyConfig _resolveActualType(ClassElement clazz) {
    final annotatedElement = clazz;
    _typeImpl = _type;
    var getXRouteAnnotation = _getXRouteChecker.firstAnnotationOf(
      annotatedElement,
      throwOnUnresolved: false,
    );

    if (getXRouteAnnotation != null) {
      final getXRoute = ConstantReader(getXRouteAnnotation);
      final name = getXRoute.peek('routeName')?.stringValue;
      if (name != null) {
        if (name.isNotEmpty) {
          _routeName = name;
        } else {
          _routeName = clazz.name;
        }
      }
    }

    final executableInitializer = clazz.constructors.first; // TODO: Support defining which constructor to use
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

    _constructorName = executableInitializer.name;
    for (ParameterElement param in executableInitializer.parameters) {
      final resolvedType = param.type is FunctionType ? _typeResolver.resolveFunctionType(param.type as FunctionType) : _typeResolver.resolveType(param.type);

      _dependencies.add(InjectedDependency(
        type: resolvedType,
        paramName: param.name,
        isPositional: param.isPositional,
      ));
    }

    return DependencyConfig(
      type: _type,
      typeImpl: _typeImpl,
      dependencies: _dependencies,
      dependsOn: _dependsOn,
      signalsReady: _signalsReady,
      instanceName: _routeName,
      moduleConfig: _moduleConfig,
      constructorName: _constructorName,
    );
  }
}
