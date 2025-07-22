import 'package:fhir_reader/src/value_sets/vs_entry.dart';
import 'package:fhir_reader/src/value_sets/vs_meta.dart';

class VsValueSets {
  String? resourceType;
  String? id;
  VsMeta? meta;
  String? type;
  VsEntry? entry;

  VsValueSets({this.resourceType, this.id, this.meta, this.type, this.entry});

  factory VsValueSets.fromJson(Map<String, dynamic> json) {
    return VsValueSets(
      resourceType: json['resourceType'],
      id: json['id'],
      meta: json['meta'] != null ? VsMeta.fromJson(json['meta']) : null,
      type: json['type'],
      entry: json['entry'] != null ? VsEntry.fromJson(json['entry']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resourceType': resourceType,
      'id': id,
      'meta': meta?.toJson(),
      'type': type,
      'entry': entry?.toJson(),
    }..removeWhere((key, value) => value == null || (value is List && value.isEmpty));
  }
}
