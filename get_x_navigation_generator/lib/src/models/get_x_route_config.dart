import 'package:collection/collection.dart';
import 'package:get_x_navigation_generator/src/models/importable_type.dart';
import 'package:get_x_navigation_generator_annotations/get_x_navigation_generator_annotations.dart';

class GetXRouteConfig {
  final bool generateMethod;
  final bool generatePage;
  final bool isFullscreenDialog;
  final String routeName;
  final String constructorName;
  final ImportableType type;
  final ImportableType? returnType;
  final NavigationType? navigationType;
  final List<ImportableType> parameters;
  final List<ImportableType> middlewares;

  GetXRouteConfig({
    required this.type,
    required this.routeName,
    required this.returnType,
    required this.constructorName,
    required this.navigationType,
    required this.parameters,
    required this.middlewares,
    required this.generateMethod,
    required this.generatePage,
    required this.isFullscreenDialog,
  });

  String get navigationTypeAsString {
    switch (navigationType) {
      case NavigationType.popAllAndPush:
        return 'offAllNamed';
      case NavigationType.popAndPush:
        return 'offNamed';
      case NavigationType.push:
      case null:
        return 'toNamed';
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.toMap(),
      'returnType': returnType?.toMap(),
      'routeName': routeName,
      'constructorName': constructorName,
      'navigationType': navigationType?.index,
      'parameters': parameters.map((x) => x.toMap()).toList(),
      'middlewares': middlewares.map((x) => x.toMap()).toList(),
      'isFullscreenDialog': isFullscreenDialog,
      'generateMethod': generateMethod,
      'generatePage': generatePage,
    };
  }

  factory GetXRouteConfig.fromMap(Map<String, dynamic> map) {
    return GetXRouteConfig(
      type: ImportableType.fromMap(map['type'] as Map<String, dynamic>),
      returnType: map['returnType'] != null
          ? ImportableType.fromMap(map['returnType'] as Map<String, dynamic>)
          : null,
      routeName: map['routeName'] as String? ?? '',
      constructorName: map['constructorName'] as String? ?? '',
      navigationType: NavigationType.values
          .firstWhereOrNull((e) => e.index == map['navigationType']),
      parameters: List<ImportableType>.from(map['parameters']?.map(
              (dynamic x) => ImportableType.fromMap(x as Map<String, dynamic>))
          as Iterable),
      middlewares: List<ImportableType>.from(map['middlewares']?.map(
              (dynamic x) => ImportableType.fromMap(x as Map<String, dynamic>))
          as Iterable),
      isFullscreenDialog: map['isFullscreenDialog'] as bool,
      generateMethod: map['generateMethod'] as bool,
      generatePage: map['generatePage'] as bool,
    );
  }
}
