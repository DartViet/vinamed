import 'package:fhir_reader/src/value_sets/vs_designation_item.dart';
import 'package:fhir_reader/src/value_sets/vs_extension_item.dart';

class VsConceptItem {
  String code;
  String? display;
  String? definition;
  List<VsDesignationItem>? designation;
  List<VsConceptItem>? concept;
  List<VSExtensionItem>? extension;

  VsConceptItem({
    required this.code,
    this.display,
    this.definition,
    this.designation,
    this.concept,
    this.extension,
  });

  factory VsConceptItem.fromJson(Map<String, dynamic> json) {
    return VsConceptItem(
      code: json['code'],
      display: json['display'],
      definition: json['definition'],
      designation: json['designation'] != null
          ? (json['designation'] as List).map((e) => VsDesignationItem.fromJson(e)).toList()
          : null,
      concept: json['concept'] != null
          ? (json['concept'] as List).map((e) => VsConceptItem.fromJson(e)).toList()
          : null,
      extension: json['extension'] != null
          ? (json['extension'] as List).map((e) => VSExtensionItem.fromJson(e)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'display': display,
      'definition': definition,
      'designation': designation?.map((e) => e.toJson()).toList(),
      'concept': concept?.map((e) => e.toJson()).toList(),
      'extension': extension?.map((e) => e.toJson()).toList(),
    }..removeWhere((key, value) => value == null);
  }
}
