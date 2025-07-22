import 'package:fhir_reader/src/value_sets/vs_use1.dart';

class VsDesignationItem {
  VsUse use;
  String value;
  String? language;

  VsDesignationItem({required this.use, required this.value, this.language});

  factory VsDesignationItem.fromJson(Map<String, dynamic> json) {
    return VsDesignationItem(
      use: VsUse.fromJson(json['use']),
      value: json['value'],
      language: json['language'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'use': use.toJson(), 'value': value, 'language': language}
      ..removeWhere((key, value) => value == null);
  }
}
