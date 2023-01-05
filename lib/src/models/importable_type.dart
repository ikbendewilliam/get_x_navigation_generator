class ImportableType {
  final String? import;
  final String? name;
  final String className;
  final bool isRequired;
  final bool isNullable;
  final List<ImportableType> typeArguments;

  const ImportableType({
    required this.className,
    this.name,
    this.import,
    this.isRequired = false,
    this.isNullable = false,
    this.typeArguments = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'import': import,
      'className': className,
      'name': name,
      'isRequired': isRequired,
      'isNullable': isNullable,
      'typeArguments': typeArguments.map((x) => x.toMap()).toList(),
    };
  }

  factory ImportableType.fromMap(Map<String, dynamic> map) {
    return ImportableType(
      import: map['import'],
      className: map['className'] ?? '',
      name: map['name'],
      isRequired: map['isRequired'] ?? false,
      isNullable: map['isNullable'] ?? false,
      typeArguments: List<ImportableType>.from(map['typeArguments']?.map((x) => ImportableType.fromMap(x))),
    );
  }

  @override
  String toString() {
    return 'ImportableType(import: $import, className: $className, name: $name, isRequired: $isRequired, isNullable: $isNullable, typeArguments: $typeArguments)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ImportableType &&
        other.import == import &&
        other.className == className &&
        other.name == name &&
        other.isRequired == isRequired &&
        other.isNullable == isNullable;
  }

  @override
  int get hashCode {
    return import.hashCode ^ className.hashCode ^ name.hashCode ^ isRequired.hashCode ^ isNullable.hashCode ^ typeArguments.hashCode;
  }
}
