import 'package:ltdmed/fhir/primitive.dart';

class VQuantity {
  Vdecimal vdecimal;
  VCode comparator; // e.g., <, >, <=, >=
  Vstring unit; // e.g., "mg", "ml"
  Vuri system; // e.g., "http://unitsofmeasure.org"
  VCode code; // e.g., "mg" for milligrams

  VQuantity({required this.vdecimal, required this.comparator, required this.unit, required this.system, required this.code});

  Map<String, dynamic> toJson() {
    return {'vdecimal': vdecimal, 'comparator': comparator, 'unit': unit, 'system': system, 'code': code};
  }

  factory VQuantity.fromJson(Map<String, dynamic> json) {
    return VQuantity(vdecimal: json['vdecimal'], comparator: json['comparator'], unit: json['unit'], system: json['system'], code: json['code']);
  }
}

typedef VDistance = VQuantity; // A specific type of quantity representing distance
typedef VDuration = VQuantity; // A specific type of quantity representing duration
typedef VCount = VQuantity; // A specific type of quantity representing count
typedef VSimpleQuantity = VQuantity; // A simple quantity without specific units or systems
