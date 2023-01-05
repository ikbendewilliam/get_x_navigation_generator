import 'importable_type.dart';

class ModuleConfig {
  final bool isAbstract;
  final ImportableType type;
  final String initializerName;

  const ModuleConfig({
    required this.isAbstract,
    required this.type,
    required this.initializerName,
  });

  ModuleConfig copyWith({
    bool? isAbstract,
    bool? isModuleMethod,
    ImportableType? module,
    String? initializerName,
  }) {
    if ((isAbstract == null || identical(isAbstract, this.isAbstract)) &&
        (module == null || identical(module, type)) &&
        (initializerName == null || identical(initializerName, this.initializerName))) {
      return this;
    }

    return ModuleConfig(
      isAbstract: isAbstract ?? this.isAbstract,
      type: module ?? type,
      initializerName: initializerName ?? this.initializerName,
    );
  }

  @override
  String toString() {
    return 'ModuleConfig{isAbstract: $isAbstract, module: $type, initializerName: $initializerName}';
  }

  @override
  bool operator ==(Object other) => identical(this, other) || (other is ModuleConfig && runtimeType == other.runtimeType && type == other.type);

  @override
  int get hashCode => type.hashCode;

  factory ModuleConfig.fromJson(Map<String, dynamic> json) {
    return ModuleConfig(
      isAbstract: json['isAbstract'] as bool,
      type: ImportableType.fromJson(json['type']),
      initializerName: json['initializerName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_cast
    return {
      'isAbstract': isAbstract,
      'type': type,
      'initializerName': initializerName,
    } as Map<String, dynamic>;
  }
}
