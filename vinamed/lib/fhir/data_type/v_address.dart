import 'package:ltdmed/fhir/data_type/v_period.dart';
import 'package:ltdmed/fhir/primitive.dart';

class VAddress {
  VCode use; // home | work | temp | old | billing - purpose of this address
  Vstring type; // postal | physical | both - type of address
  Vstring text; // Text representation of the address
  List<Vstring> line; // Street address lines
  Vstring city; // City name
  Vstring district; // District or county name
  Vstring state; // State or province name
  Vstring postalCode; // Postal code or ZIP code
  Vstring country; // Country name
  VPeriod period; // Period during which the address is valid

  VAddress({
    required this.use,
    required this.type,
    required this.text,
    required this.line,
    required this.city,
    required this.district,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.period,
  });

  Map<String, dynamic> toJson() {
    return {
      'use': use,
      'type': type,
      'text': text,
      'line': line,
      'city': city,
      'district': district,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'period': period.toJson(),
    };
  }

  factory VAddress.fromJson(Map<String, dynamic> json) {
    return VAddress(
      use: json['use'],
      type: json['type'],
      text: json['text'],
      line: List<String>.from(json['line']),
      city: json['city'],
      district: json['district'],
      state: json['state'],
      postalCode: json['postalCode'],
      country: json['country'],
      period: VPeriod.fromJson(json['period']),
    );
  }
}
