class VsCodingItem {
  String? code;
  String? display;
  String? system;

  VsCodingItem({this.code, this.display, this.system});

  factory VsCodingItem.fromJson(Map<String, dynamic> json) {
    return VsCodingItem(code: json['code'], display: json['display'], system: json['system']);
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'display': display, 'system': system}
      ..removeWhere((key, value) => value == null || (value is String && value.isEmpty));
  }
}
