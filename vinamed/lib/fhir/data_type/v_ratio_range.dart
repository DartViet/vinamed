import 'package:ltdmed/fhir/data_type/v_quantity.dart';

class VRatioRange {
  VSimpleQuantity? lowNumerator; // The lower bound numerator of the ratio
  VSimpleQuantity? highNumerator; // The upper bound numerator of the ratio
  VSimpleQuantity? denominator; // The denominator of the ratio

  VRatioRange({this.lowNumerator, this.highNumerator, this.denominator});

  Map<String, dynamic> toJson() {
    return {'lowNumerator': lowNumerator, 'highNumerator': highNumerator, 'denominator': denominator};
  }

  factory VRatioRange.fromJson(Map<String, dynamic> json) {
    return VRatioRange(
      lowNumerator: json['lowNumerator'] != null ? VSimpleQuantity.fromJson(json['lowNumerator']) : null,
      highNumerator: json['highNumerator'] != null ? VSimpleQuantity.fromJson(json['highNumerator']) : null,
      denominator: json['denominator'] != null ? VSimpleQuantity.fromJson(json['denominator']) : null,
    );
  }
}
