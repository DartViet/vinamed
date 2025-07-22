class VsValueQuantity {
  double? value;
  String? unit;
  String? system;
  String? code;
  String? comparator;

  VsValueQuantity({this.value, this.unit, this.system, this.code, this.comparator});

  factory VsValueQuantity.fromJson(Map<String, dynamic> json) {
    return VsValueQuantity(
      value: json['value']?.toDouble(),
      unit: json['unit'],
      system: json['system'],
      code: json['code'],
      comparator: json['comparator'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'value': value, 'unit': unit, 'system': system, 'code': code, 'comparator': comparator}
      ..removeWhere((key, value) => value == null || (value is String && value.isEmpty));
  }
}
