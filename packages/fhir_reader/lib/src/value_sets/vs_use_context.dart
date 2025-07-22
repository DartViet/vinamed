import 'package:fhir_reader/src/value_sets/vs_code_item.dart';
import 'package:fhir_reader/src/value_sets/vs_value_quantity.dart';

class VsUseContext {
  List<VsCodeItem>? code;
  List<VsValueQuantity>? valueQuantity;

  VsUseContext({this.code, this.valueQuantity});

  factory VsUseContext.fromJson(Map<String, dynamic> json) {
    return VsUseContext(
      code: (json['code'] as List<dynamic>?)?.map((item) => VsCodeItem.fromJson(item)).toList(),
      valueQuantity: (json['valueQuantity'] as List<dynamic>?)
          ?.map((item) => VsValueQuantity.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code?.map((item) => item.toJson()).toList(),
      'valueQuantity': valueQuantity?.map((item) => item.toJson()).toList(),
    }..removeWhere((key, value) => value == null || (value is List && value.isEmpty));
  }
}
