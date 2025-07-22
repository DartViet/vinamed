import 'package:ltdmed/fhir/data_type/v_quantity.dart';

class VRange {
  VQuantity? low; // The lower bound of the range
  VQuantity? high; // The upper bound of the range

  VRange({this.low, this.high});

  Map<String, dynamic> toJson() {
    return {'low': low?.toJson(), 'high': high?.toJson()};
  }

  factory VRange.fromJson(Map<String, dynamic> json) {
    return VRange(low: json['low'] != null ? VQuantity.fromJson(json['low']) : null, high: json['high'] != null ? VQuantity.fromJson(json['high']) : null);
  }
}
