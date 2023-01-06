import 'package:get_x_navigation_generator/src/models/importable_type.dart';

class GetXRouteConfig {
  final ImportableType type;
  final ImportableType? returnType;
  final String routeName;
  final String constructorName;
  final List<ImportableType> parameters;

  GetXRouteConfig({
    required this.type,
    required this.routeName,
    required this.returnType,
    required this.constructorName,
    required this.parameters,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type.toMap(),
      'returnType': returnType?.toMap(),
      'routeName': routeName,
      'constructorName': constructorName,
      'parameters': parameters.map((x) => x.toMap()).toList(),
    };
  }

  factory GetXRouteConfig.fromMap(Map<String, dynamic> map) {
    return GetXRouteConfig(
      type: ImportableType.fromMap(map['type']),
      returnType: map['returnType'] != null ? ImportableType.fromMap(map['returnType']) : null,
      routeName: map['routeName'] ?? '',
      constructorName: map['constructorName'] ?? '',
      parameters: List<ImportableType>.from(map['parameters']?.map((x) => ImportableType.fromMap(x))),
    );
  }

  @override
  String toString() {
    return 'GetXRouteConfig(type: $type, returnType: $returnType, routeName: $routeName, constructorName: $constructorName, parameters: $parameters)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetXRouteConfig && other.type == type && other.returnType == returnType && other.routeName == routeName && other.constructorName == constructorName;
  }

  @override
  int get hashCode {
    return type.hashCode ^ returnType.hashCode ^ routeName.hashCode ^ constructorName.hashCode ^ parameters.hashCode;
  }
}
