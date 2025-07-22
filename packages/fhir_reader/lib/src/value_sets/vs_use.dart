class VsUse {
  String? system;
  String? code;
  String? display;

  VsUse({this.system, this.code, this.display});

  factory VsUse.fromJson(Map<String, dynamic> json) {
    return VsUse(system: json['system'], code: json['code'], display: json['display']);
  }

  Map<String, dynamic> toJson() {
    return {'system': system, 'code': code, 'display': display}
      ..removeWhere((key, value) => value == null);
  }
}
