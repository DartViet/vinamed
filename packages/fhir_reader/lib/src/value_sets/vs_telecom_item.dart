class VsTelecomItem {
  String system;
  String value;

  VsTelecomItem({required this.system, required this.value});

  factory VsTelecomItem.fromJson(Map<String, dynamic> json) {
    return VsTelecomItem(system: json['system'], value: json['value']);
  }

  Map<String, dynamic> toJson() {
    return {'system': system, 'value': value};
  }
}
