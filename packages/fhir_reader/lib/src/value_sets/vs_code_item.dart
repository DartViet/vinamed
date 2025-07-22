class VsCodeItem {
  String? system;
  String? code;

  VsCodeItem({this.system, this.code});

  factory VsCodeItem.fromJson(Map<String, dynamic> json) {
    return VsCodeItem(system: json['system'], code: json['code']);
  }

  Map<String, dynamic> toJson() {
    return {'system': system, 'code': code}
      ..removeWhere((key, value) => value == null || (value is String && value.isEmpty));
  }
}
