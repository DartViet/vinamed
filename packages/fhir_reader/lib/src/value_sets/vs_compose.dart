import 'package:fhir_reader/src/value_sets/vs_include_item.dart';

class VsCompose {
  List<VsIncludeItem>? include;
  String? lockedDate;
  bool? inactive;

  VsCompose();

  factory VsCompose.fromJson(Map<String, dynamic> json) {
    return VsCompose()
      ..include = (json['include'] as List<dynamic>?)
          ?.map((item) => VsIncludeItem.fromJson(item))
          .toList()
      ..lockedDate = json['lockedDate']
      ..inactive = json['inactive'];
  }

  Map<String, dynamic> toJson() {
    return {
      'include': include?.map((item) => item.toJson()).toList(),
      'lockedDate': lockedDate,
      'inactive': inactive,
    }..removeWhere((key, value) => value == null);
  }
}
