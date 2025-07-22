import 'package:fhir_reader/src/value_sets/vs_coding_item.dart';

class VsJurisdictionItem {
  List<VsCodingItem>? coding;

  VsJurisdictionItem({this.coding});

  factory VsJurisdictionItem.fromJson(Map<String, dynamic> json) {
    return VsJurisdictionItem(
      coding: (json['coding'] as List<dynamic>?)
          ?.map((item) => VsCodingItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'coding': coding?.map((item) => item.toJson()).toList()}
      ..removeWhere((key, value) => value == null || (value is List && value.isEmpty));
  }
}
