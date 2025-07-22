import 'package:ltdmed/fhir/data_type/v_period.dart';
import 'package:ltdmed/fhir/primitive.dart';

class VHumanName {
  Vstring? use; // usual | official | temp | nickname | anonymous | old | maiden - purpose of this name
  Vstring? text; // Text representation of the full name
  Vstring? family; // Family name (surname)
  List<Vstring>? given; // Given names (first names)
  List<Vstring>? prefix; // Prefixes (e.g., Dr., Mr., Mrs
  Vstring? suffix; // Suffixes (e.g., Jr., Sr., III)
  VPeriod? period; // Time period during which the name was valid

  VHumanName({this.use, this.text, this.family, this.given, this.prefix, this.suffix, this.period});

  Map<String, dynamic> toJson() {
    return {'use': use, 'text': text, 'family': family, 'given': given, 'prefix': prefix, 'suffix': suffix, 'period': period?.toJson()};
  }

  factory VHumanName.fromJson(Map<String, dynamic> json) {
    return VHumanName(
      use: json['use'],
      text: json['text'],
      family: json['family'],
      given: (json['given'].cast<List<dynamic>>() as List?)?.map((e) => e.toString()).toList(),
      prefix: (json['prefix'].cast<List<dynamic>>() as List?)?.map((e) => e.toString()).toList(),
      suffix: json['suffix'],
      period: json['period'] != null ? VPeriod.fromJson(json['period']) : null,
    );
  }
}
