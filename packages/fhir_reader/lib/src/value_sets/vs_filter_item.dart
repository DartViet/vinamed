class VSFilterItem {
  String? code;
  String? description;
  List<String>? operator;
  String? value;
  String? property;
  String? op;

  VSFilterItem({this.code, this.description, this.operator, this.value, this.property, this.op});

  factory VSFilterItem.fromJson(Map<String, dynamic> json) {
    return VSFilterItem(
      code: json['code'],
      description: json['description'],
      operator: List<String>.from(json['operator']),
      value: json['value'],
      property: json['property'],
      op: json['op'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
        'code': code,
        'description': description,
        'operator': operator,
        'value': value,
        'property': property,
        'op': op,
      }
      ..removeWhere((key, value) => value == null)
      ..removeWhere((key, value) => value is String && value.isEmpty);
  }
}
