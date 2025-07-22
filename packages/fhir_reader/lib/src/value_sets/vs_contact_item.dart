import 'package:fhir_reader/src/value_sets/vs_telecom_item.dart';

class VSContactItem {
  List<VsTelecomItem> telecom; // List of telecom items for contact

  VSContactItem({required this.telecom});

  factory VSContactItem.fromJson(Map<String, dynamic> json) {
    return VSContactItem(
      telecom: (json['telecom'] as List)
          .map((item) => VsTelecomItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'telecom': telecom.map((item) => item.toJson()).toList()};
  }
}
