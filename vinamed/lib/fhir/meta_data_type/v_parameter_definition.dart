import 'package:ltdmed/fhir/primitive.dart';

class VParameterDefinition {
  VCode? name; // Name of the parameter
  VCode? use; // Use of the parameter (e.g., input, output)
  Vinteger? min; // Minimum number of occurrences
  Vstring? max; // Maximum number of occurrences
  VCode? type; // Type of the parameter (e.g., string, integer)
  VCanonical? profile; // Profile URL for the parameter of StructureDefinition

  VParameterDefinition({this.name, this.use, this.min, this.max, this.type, this.profile});

  Map<String, dynamic> toJson() {
    return {'name': name, 'use': use, 'min': min, 'max': max, 'type': type, 'profile': profile}..removeWhere((key, value) => value == null);
  }

  factory VParameterDefinition.fromJson(Map<String, dynamic> json) {
    return VParameterDefinition(name: json['name'], use: json['use'], min: json['min'], max: json['max'], type: json['type'], profile: json['profile']);
  }
}
