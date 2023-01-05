// holds extracted data from annotation & element
// to be used later when generating the register function

import 'package:collection/collection.dart';
import 'package:get_x_navigation_generator/src/models/module_config.dart';

import 'dispose_function_config.dart';
import 'importable_type.dart';
import 'injected_dependency.dart';

class DependencyConfig {
  final ImportableType type;
  final ImportableType typeImpl;

  final List<InjectedDependency> dependencies;
  final String? instanceName;
  final bool? signalsReady;
  final List<String> environments;
  final String? constructorName;
  final String? postConstruct;
  final bool isAsync;
  final bool postConstructReturnsSelf;
  final List<ImportableType> dependsOn;
  final bool preResolve;
  final ModuleConfig? moduleConfig;
  final DisposeFunctionConfig? disposeFunction;
  final int orderPosition;
  final String? scope;

  const DependencyConfig({
    required this.type,
    required this.typeImpl,
    this.dependencies = const [],
    this.instanceName,
    this.signalsReady,
    this.environments = const [],
    this.constructorName = '',
    this.isAsync = false,
    this.dependsOn = const [],
    this.preResolve = false,
    this.moduleConfig,
    this.disposeFunction,
    this.orderPosition = 0,
    this.scope,
    this.postConstructReturnsSelf = false,
    this.postConstruct,
  });

  // used for testing
  factory DependencyConfig.factory(String type, {List<String> deps = const [], List<String> envs = const [], int order = 0}) {
    return DependencyConfig(
      type: ImportableType(name: type),
      typeImpl: ImportableType(name: type),
      environments: envs,
      orderPosition: order,
      dependencies: deps
          .map(
            (e) => InjectedDependency(
              type: ImportableType(name: e),
              paramName: e.toLowerCase(),
            ),
          )
          .toList(),
    );
  }

  // used for testing
  factory DependencyConfig.singleton(String type, {List<String> deps = const [], int order = 0}) {
    return DependencyConfig(
      type: ImportableType(name: type),
      typeImpl: ImportableType(name: type),
      orderPosition: order,
      dependencies: deps
          .map(
            (e) => InjectedDependency(
              type: ImportableType(name: e),
              paramName: e.toLowerCase(),
            ),
          )
          .toList(),
    );
  }

  @override
  String toString() {
    return 'DependencyConfig{type: $type, typeImpl: $typeImpl, dependencies: $dependencies, instanceName: $instanceName, signalsReady: $signalsReady, environments: $environments, constructorName: $constructorName, isAsync: $isAsync, dependsOn: $dependsOn, preResolve: $preResolve, moduleConfig: $moduleConfig,scope: $scope}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DependencyConfig &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          typeImpl == other.typeImpl &&
          const ListEquality().equals(dependencies, other.dependencies) &&
          instanceName == other.instanceName &&
          signalsReady == other.signalsReady &&
          const ListEquality().equals(environments, other.environments) &&
          constructorName == other.constructorName &&
          isAsync == other.isAsync &&
          const ListEquality().equals(dependsOn, other.dependsOn) &&
          preResolve == other.preResolve &&
          disposeFunction == other.disposeFunction &&
          scope == other.scope &&
          moduleConfig == other.moduleConfig &&
          postConstruct == other.postConstruct &&
          postConstructReturnsSelf == other.postConstructReturnsSelf &&
          orderPosition == other.orderPosition);

  @override
  int get hashCode =>
      type.hashCode ^
      typeImpl.hashCode ^
      const ListEquality().hash(dependencies) ^
      instanceName.hashCode ^
      signalsReady.hashCode ^
      const ListEquality().hash(environments) ^
      constructorName.hashCode ^
      isAsync.hashCode ^
      const ListEquality().hash(dependsOn) ^
      preResolve.hashCode ^
      disposeFunction.hashCode ^
      moduleConfig.hashCode ^
      orderPosition.hashCode ^
      postConstruct.hashCode ^
      postConstructReturnsSelf.hashCode ^
      scope.hashCode;

  factory DependencyConfig.fromJson(Map<dynamic, dynamic> json) {
    ModuleConfig? moduleConfig;
    DisposeFunctionConfig? disposeFunction;

    List<ImportableType> dependsOn = [];
    List<InjectedDependency> dependencies = [];

    if (json['moduleConfig'] != null) {
      moduleConfig = ModuleConfig.fromJson(json['moduleConfig']);
    }

    if (json['disposeFunction'] != null) {
      disposeFunction = DisposeFunctionConfig.fromJson(json['disposeFunction']);
    }

    if (json['dependencies'] != null) {
      json['dependencies'].forEach((v) {
        dependencies.add(InjectedDependency.fromJson(v));
      });
    }

    if (json['dependsOn'] != null) {
      json['dependsOn'].forEach((v) {
        dependsOn.add(ImportableType.fromJson(v));
      });
    }

    return DependencyConfig(
      type: ImportableType.fromJson(json['type']),
      typeImpl: ImportableType.fromJson(json['typeImpl']),
      dependencies: dependencies,
      instanceName: json['instanceName'],
      signalsReady: json['signalsReady'],
      environments: json['environments']?.cast<String>(),
      constructorName: json['constructorName'],
      postConstruct: json['postConstruct'],
      isAsync: json['isAsync'] as bool,
      dependsOn: dependsOn,
      preResolve: json['preResolve'] as bool,
      postConstructReturnsSelf: json['postConstructReturnsSelf'] as bool,
      moduleConfig: moduleConfig,
      disposeFunction: disposeFunction,
      orderPosition: json['orderPosition'] as int,
      scope: json['scope'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type.toJson(),
        'typeImpl': typeImpl.toJson(),
        "isAsync": isAsync,
        "postConstructReturnsSelf": postConstructReturnsSelf,
        "preResolve": preResolve,
        if (moduleConfig != null) 'moduleConfig': moduleConfig!.toJson(),
        if (disposeFunction != null) 'disposeFunction': disposeFunction!.toJson(),
        "dependsOn": dependsOn.map((v) => v.toJson()).toList(),
        "environments": environments,
        "dependencies": dependencies.map((v) => v.toJson()).toList(),
        if (instanceName != null) "instanceName": instanceName,
        if (signalsReady != null) "signalsReady": signalsReady,
        if (constructorName != null) "constructorName": constructorName,
        if (postConstruct != null) "postConstruct": postConstruct,
        "orderPosition": orderPosition,
        if (scope != null) "scope": scope,
      };

  bool get isFromModule => moduleConfig != null;

  List<InjectedDependency> get positionalDependencies => dependencies.where((d) => d.isPositional).toList();

  List<InjectedDependency> get namedDependencies => dependencies.where((d) => !d.isPositional).toList();
}
