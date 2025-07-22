import 'package:ltdmed/fhir/data_type/v_quantity.dart';

class VRatio {
  VQuantity? numerator; // The numerator of the ratio
  VSimpleQuantity? denominator; // The denominator of the ratio

  VRatio({this.numerator, this.denominator});
  Map<String, dynamic> toJson() {
    return {'numerator': numerator?.toJson(), 'denominator': denominator?.toJson()};
  }

  factory VRatio.fromJson(Map<String, dynamic> json) {
    return VRatio(
      numerator: json['numerator'] != null ? VQuantity.fromJson(json['numerator']) : null,
      denominator: json['denominator'] != null ? VSimpleQuantity.fromJson(json['denominator']) : null,
    );
  }
}
