import 'package:fhir_reader/src/value_sets/vs_concept_item.dart';
import 'package:fhir_reader/src/value_sets/vs_filter_item.dart';

class VsIncludeItem {
  String? system;
  List<VSFilterItem>? filter;
  List<VsConceptItem>? concept;
  List<String>? property;
  List<String>? valueSet;
  String? version;

  VsIncludeItem();

  factory VsIncludeItem.fromJson(Map<String, dynamic> json) {
    return VsIncludeItem()
      ..system = json['system']
      ..filter = (json['filter'] as List<dynamic>?)
          ?.map((item) => VSFilterItem.fromJson(item))
          .toList()
      ..concept = (json['concept'] as List<dynamic>?)
          ?.map((item) => VsConceptItem.fromJson(item))
          .toList()
      ..property = (json['property'] as List<dynamic>?)?.cast<String>()
      ..valueSet = (json['valueSet'] as List<dynamic>?)?.cast<String>()
      ..version = json['version'];
  }

  Map<String, dynamic> toJson() {
    return {
      'system': system,
      'filter': filter?.map((item) => item.toJson()).toList(),
      'concept': concept?.map((item) => item.toJson()).toList(),
      'property': property,
      'valueSet': valueSet,
      'version': version,
    }..removeWhere((key, value) => value == null);
  }
}
