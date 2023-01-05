import 'importable_type.dart';

class InjectedDependency {
  ImportableType type;
  String? instanceName;
  String paramName;
  bool isPositional;

  InjectedDependency({
    required this.type,
    required this.paramName,
    this.instanceName,
    this.isPositional = true,
  });

  @override
  String toString() {
    return 'InjectedDependency{type: $type, instanceName: $instanceName, paramName: $paramName, isPositional: $isPositional}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InjectedDependency &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          instanceName == other.instanceName &&
          paramName == other.paramName &&
          isPositional == other.isPositional);

  @override
  int get hashCode => type.hashCode ^ instanceName.hashCode ^ paramName.hashCode ^ isPositional.hashCode;

  factory InjectedDependency.fromJson(Map<String, dynamic> json) {
    return InjectedDependency(
      type: ImportableType.fromJson(json['type']),
      instanceName: json['instanceName'],
      paramName: json['paramName'],
      isPositional: json['isPositional'],
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_cast
    return {
      'type': type,
      'instanceName': instanceName,
      'paramName': paramName,
      'isPositional': isPositional,
    } as Map<String, dynamic>;
  }
}
